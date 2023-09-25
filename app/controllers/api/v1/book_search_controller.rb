class Api::V1::BookSearchController < ApplicationController

  def index
    if params[:location].empty?
      render json: { error: "No location provided" }, status: 400
    elsif params[:quantity].to_i < 1
      render json: { error: "Invalid Quantity" }, status: 400
    else
      location = params[:location]
      quantity = params[:quantity]
      books = BookFacade.find_books(location, quantity)
      render json: BooksSerializer.new(books)
    end
  end
end