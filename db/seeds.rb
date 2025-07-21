# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

30.times do |i|
  num = i + 1
  title = "Test#{num}"
  content = "<p>#{title}</p>"
  image_path = Rails.root.join("db/seed_images/1.jpg")

  unless File.exist?(image_path)
    next
  end

  post = Post.new(
    title: title,
    content: content,
    user_id: 1
  )

  post.main_image.attach(
    io: File.open(image_path),
    filename: "#{num}.jpg",
    content_type: "image/jpeg"
  )

  post.save!
end

