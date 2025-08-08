class PostSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers
  attributes :title

  attribute :content do |post|
    post.content.body
  end

  attribute :gallery_urls do |post|
    post.gallery.map { |img| Rails.application.routes.url_helpers.url_for(img) }
  end
end
