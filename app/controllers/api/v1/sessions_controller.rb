class Api::V1::SessionsController < ApplicationController
  def create
    puts params.inspect
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      render json: UsersSerializer.new(user).to_json, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :bad_request
    end
  end
end