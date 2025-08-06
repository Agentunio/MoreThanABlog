class PagesSerializer
  include JSONAPI::Serializer
  attributes :title

  attribute :content do |page|
    page.content.body
  end

end
