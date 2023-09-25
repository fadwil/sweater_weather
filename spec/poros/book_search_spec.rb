require "rails_helper"

RSpec.describe BookSearch do
  it "exists and has attributes" do
    data = { destination: "gainesville, fl",
      forecast: { summary: "cloudy with a chance of meatballs",
                  temperature: "95 F"
                },
      total_books_found: 172,
      books: [{
        "isbn": [
          "0762507845",
          "9780762507849"
        ],
        title: "Gainesville, FL",
        }
      ]
    }

    search = BookSearch.new(data)

    expect(search).to be_a(BookSearch)
    expect(search.id).to eq("null")
    expect(search.type).to eq("books")
    expect(search.destination).to eq("gainesville, fl")
    expect(search.forecast).to be_a(Hash)
    expect(search.forecast[:summary]).to eq("cloudy with a chance of meatballs")
    expect(search.forecast[:temperature]).to eq("95 F")
    expect(search.total_books_found).to eq(172)
    expect(search.books).to be_a(Array)
    expect(search.books.first).to be_a(Hash)
    expect(search.books.first[:isbn]).to be_a(Array)
    expect(search.books.first[:isbn].first).to be_a(String)
    expect(search.books.first[:isbn].last).to be_a(String)
    expect(search.books.first[:title]).to be_a(String)
  end
end