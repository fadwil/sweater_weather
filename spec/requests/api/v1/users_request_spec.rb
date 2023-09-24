require "rails_helper"

RSpec.describe "users request" do
  it "creates a user with valid credentials" do
    data = {
      "email": "wrfady@gmail.com",
      "password": "pass123",
      "password_confirmation": "pass123"
    }
    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v1/users", headers: headers, params: JSON.generate(data)
    
    expect(response).to have_http_status(201)

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to be_a(Hash)
    expect(parsed[:data]).to be_a(Hash)
    expect(parsed[:data].keys).to eq([:id, :type, :attributes])

    expect(parsed[:data][:id]).to be_a(String)
    expect(parsed[:data][:type]).to eq("users")
    expect(parsed[:data][:attributes]).to be_a(Hash)
    expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])
    expect(parsed[:data][:attributes][:email]).to eq("wrfady@gmail.com")
    expect(parsed[:data][:attributes][:api_key]).to be_a(String)
    expect(parsed[:data][:attributes][:api_key]).to eq(User.last.api_key)

  end
end