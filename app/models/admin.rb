class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless /@gmail.com || @tamu.edu\z/.match?(email)

    # Create associated User table
    User.create_with(email: email, full_name: full_name, avatar: avatar_url, username: 'guest', role: 'guest',
                     bio: 'Is a guest'
    ).find_or_create_by!(email: email)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)

    # Update Profile Image on relogin
    User.find_by(email: email).update(avatar: avatar_url)
  end
end
