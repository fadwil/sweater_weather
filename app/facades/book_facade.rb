class BookFacade
  def self.find_books(location)
    request = BookService.search_books(location)
  end
end