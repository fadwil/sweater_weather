class BookSerializer
  include JSONAPI::Serializer
  attributes :isbn, :title
end