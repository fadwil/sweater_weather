require "rails_helper"

RSpec.describe "/api/v1/book-search" do
  describe "#index", :vcr do
    it "returns book json" do
      get "/api/v1/book-search?location=Denver, CO&quantity=5"

      book_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(book_json).to be_a(Hash)
      expect(book_json).to have_key(:data)
      expect(book_json[:data].keys).to eq([:id, :type, :attributes])
      expect(book_json[:data][:type]).to eq("books")
      expect(book_json[:data][:attributes].keys).to eq([:destination, :forecast, :total_books_found, :books])
      expect(book_json[:data][:attributes][:destination]).to eq("Denver, CO")
      expect(book_json[:data][:attributes][:forecast]).to have_key(:summary)
      expect(book_json[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(book_json[:data][:attributes][:books].count).to eq(5)
      expect(book_json[:data][:attributes][:books].first).to have_key(:isbn)
      expect(book_json[:data][:attributes][:books].first).to have_key(:title)
    end
  end
end