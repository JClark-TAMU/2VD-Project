Admin.create!([
  {email: "jonathan.clark@tamu.edu", full_name: "Jonathan Clark", uid: "103215196265443395357", avatar_url: "https://lh3.googleusercontent.com/a-/AOh14GjKHilpdz9o-rWwR26k4y2VHT8w-Ih3JViRGv4pAw=s96-c"}
])
Image.create!([
  {title: "Image of nothing", caption: "literally nothing", showOnPortfolio: false, imageLink: nil, users_id: 1, portfolios_id: nil},
  {title: "Image of something", caption: "literally nothing", showOnPortfolio: true, imageLink: nil, users_id: 1, portfolios_id: nil}
])
Portfolio.create!([
  {title: "untitled", user_id: 1}
])
User.create!([
  {username: "OASIS", email: "jonathan.clark@tamu.edu", isAdmin: true, role: "Developer", bio: "I code", portfolioID: nil, full_name: "Jonathan Clark", avatar: "https://lh3.googleusercontent.com/a-/AOh14GjKHilpdz9o-rWwR26k4y2VHT8w-Ih3JViRGv4pAw=s96-c"}
])
ActiveStorage::Blob.create!([
  {key: "9olfeyb4tixkgx0dd9j5bpqzb12m", filename: "Ameno.jpg", content_type: "image/jpeg", metadata: {"identified"=>true, "width"=>1800, "height"=>1200, "analyzed"=>true}, service_name: "amazon", byte_size: 743299, checksum: "Kd+ih2+j9XovXvbn+RojEQ=="},
  {key: "twnlzbc99uhr5dstjy1is5c2lrkl", filename: "wallhaven-4d8eqg.jpg", content_type: "image/jpeg", metadata: {"identified"=>true, "width"=>1920, "height"=>1080, "analyzed"=>true}, service_name: "amazon", byte_size: 289091, checksum: "Wju76/U4n5437nMb/f+Y8A=="}
])
ActiveStorage::Attachment.create!([
  {name: "imageLink", record_type: "Image", record_id: 1, blob_id: 1},
  {name: "imageLink", record_type: "Image", record_id: 2, blob_id: 2}
])
