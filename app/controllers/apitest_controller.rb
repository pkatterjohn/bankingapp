class ApitestController < ApplicationController
  require 'httparty'

  def getdata
    response = HTTParty.get('http://api:5000/api/v1/alldata')
    @code = response.code
    @body = response.body

  end
end
