json.extract! user, :id, :login, :password, :admin, :Organization_id, :created_at, :updated_at
json.url user_url(user, format: :json)
