json.extract! user, :id, :username, :password, :email, :isAdmin, :role, :bio, :portfolioID, :created_at, :updated_at
json.url user_url(user, format: :json)
