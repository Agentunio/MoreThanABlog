class PostsSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers 
  attributes :title, :updated_at, :slug, :custom_date

  attribute :username do |post|
    post.user.username
  end

  attribute :content do |post|
    post.content.body
  end

   attribute :main_image do |post|
    if post.main_image.attached?
      Rails.application.routes.url_helpers.url_for(post.main_image)
    end
  end
end
