class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :updated_at, :slug, :custom_date

  attribute :username do |post|
    post.user.username
  end

  attribute :content do |post|
    post.content.body
  end

end
