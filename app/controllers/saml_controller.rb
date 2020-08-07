class SamlController < ApplicationController
  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], :settings => saml_settings)

    #We validate the SAML Response and check if the user already exists in the system
    if response.is_valid?
      #authorize_success, log the user
      session[:userid] = response.nameid
      session[:attributes] = response.attributes
    else
      authorize_failure #This method shows an error message
    end
  end

  private

  def saml_settings

  idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
  # Returns OneLogin::RubySaml::Settings prepopulated with idp metadata
  settings = idp_metadata_parser.parse_remote("https://samltest.id/saml/idp")

  settings.assertion_consumer_service_url = "https://samltest.id/Shibboleth.sso/SAML2/POST"
  settings.idp_entity_id                   = "https://samltest.id/saml/sp"
  settings.name_identifier_format         = "urn:oasis:names:tc:SAML:2.0:attrname-format:uri"
  # Optional for most SAML IdPs
  settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  settings
  end
end
