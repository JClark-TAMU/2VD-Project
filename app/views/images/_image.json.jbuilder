json.extract! image, :id, :title, :caption, :created_at, :updated_at
json.url image_url(image, format: :json)
