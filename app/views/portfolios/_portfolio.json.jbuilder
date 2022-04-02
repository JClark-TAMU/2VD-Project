json.extract!(portfolio, :id, :title, :userID, :created_at, :updated_at)
json.url(portfolio_url(portfolio, format: :json))
