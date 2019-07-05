json.extract! account, :id, :user_id, :name, :account_type, :amount, :created_at, :updated_at
json.url account_url(account, format: :json)
