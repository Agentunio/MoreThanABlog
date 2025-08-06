class PostSerializer
  include JSONAPI::Serializer
  attributes :title

  attribute :content do |post|
    post.content.body
  end

end
