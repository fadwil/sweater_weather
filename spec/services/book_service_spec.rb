require "rails_helper"

RSpec.describe BookService do
  it "returns book json", :vcr do
    location = "Denver, CO"
    quantity = 5
    books = BookService.search_books(location, quantity)
    expect(books).to be_a(Hash)
    expect(books).to have_key(:numFound)
    expect(books).to have_key(:docs)
    expect(books[:docs][0]).to have_key(:isbn)
    expect(books[:docs][0]).to have_key(:title)
    expect(books[:docs][0]).to have_key(:publisher)
  end
end