unless User.exists?(email: 'web2d.development@gmail.com')
  webUser = User.create!([
    {
      username: 'Web2d',
      email: 'web2d.development@gmail.com',
      isAdmin: true,
      role: 'Organization',
      bio: 'Organizational account',
      portfolioID: 1,
      full_name: 'Web2d',
      avatar: 'https://lh3.googleusercontent.com/a/AATXAJxCWLfJltqmCrs-xBsko4MWBY54KSgVpefCEQlX=s96-c'
    }
  ]
              )
  webPort = Portfolio.create!(title: 'Web2d', user_id: webUser.id)
  webUser.update(portfolioID: webPort.id)
end