S3Client = Aws::S3::Client.new(
  access_key_id: '<%= Rails.application.credentials.dig(:aws, :access_key_id) %>',
  secret_access_key: '<%= Rails.application.credentials.dig(:aws, :secret_access_key) %>',
  region: 'us-east-2'
)
