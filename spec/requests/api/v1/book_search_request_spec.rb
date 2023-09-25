require "rails_helper"

RSpec.describe "/api/v1/book-search" do
  describe "#index", :vcr do
    it "returns book json" do
      params = { location: "Denver,CO", quantity: 5 }
      headers = { 'Content_Type' => "application/json", "Accept" => "application/json" }

      get "/api/v1/book-search", headers: headers, params: params

      book_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(book_json).to be_a(Hash)
      expect(book_json).to have_key(:data)
      expect(book_json[:data].keys).to eq([:id, :type, :attributes])
      expect(book_json[:data][:type]).to eq("books")
      expect(book_json[:data][:attributes].keys).to eq([:destination, :forecast, :total_books_found, :books])
      expect(book_json[:attributes][:destination]).to eq(params[:location])
      expect(book_json[:attributes][:forecast]).to have_key(:summary)
      expect(book_json[:attributes][:forecast]).to have_key(:temperature)
      expect(book_json[:data][:attributes][:books].count).to eq(params[:quantity])
      book_json[:data][:attributes][:books].each do |book|
        expect(book).to have_key(:isbn)
        expect(book).to have_key(:title)
      end
    end
  end
end