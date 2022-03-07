if !User.exists?(email: "jonathan.clark@tamu.edu")
  User.create!([
    {username: "OASIS", email: "jonathan.clark@tamu.edu", isAdmin: true, role: "Developer", bio: "I code", portfolioID: 1, full_name: "Jonathan Clark", avatar: "https://lh3.googleusercontent.com/a-/AOh14GjKHilpdz9o-rWwR26k4y2VHT8w-Ih3JViRGv4pAw=s96-c"}
  ])
  Portfolio.create!(title: "OASIS", user_id: 1)
end
