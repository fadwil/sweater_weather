class BookFacade
  def self.find_books(location, quantity)
    @books ||= BookService.search_books(location, quantity)

    mapquest = MapquestService.get_lat_lng(location)
    weather = ForecastService.get_forecast(location)
    books = {destination: location,
              forecast: {summary: weather[:current][:condition][:text],
              temperature: weather[:current][:temp_f]},
              total_books_found: @books[:numFound],
              books: book_hash(@books)
            }
    BookSearch.new(books)
  end

  def self.book_hash(books)
    books[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title]
      }
    end
  end
end