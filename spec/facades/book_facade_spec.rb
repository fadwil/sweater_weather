require "rails_helper"

RSpec.describe BookFacade do
  it "returns searched books", :vcr do
    location = "Denver, CO"
    quantity = 5
    books = BookFacade.find_books(location, quantity)
    expect(books).to be_a(BookSearch)
    expect(books.id).to eq("null")
    expect(books.type).to eq("books")
    expect(books.destination).to eq("Denver, CO")
    expect(books.forecast.keys).to eq([:summary, :temperature])
    expect(books.total_books_found).to eq(772)
  end
end