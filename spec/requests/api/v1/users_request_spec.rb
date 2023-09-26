require "rails_helper"

RSpec.describe "users request", type: :request do
  describe "Post /api/v1/users" do
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

    context "when credentials are invalid" do
      it "returns a 422 Unprocessable Entity statu" do
        data = {
          "email": "wrfady@gmail.com",
          "password": "pass123",
          "password_confirmation": "pass125"
        }

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/users", headers: headers, params: JSON.generate(data)

        expect(response).to have_http_status(422)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to be_a(Hash)
        expect(error).to have_key(:errors)
        expect(error[:errors]).to eq(["Password confirmation doesn't match Password"]) 
      end
    end

    context "when the email already exists" do
      it "returns a 422 Unprocessable Entity status" do
        existing_user = User.create!(email: "existing@example.com", password: "newpassword", password_confirmation: "newpassword") 
    
        data = {
          "email": "existing@example.com",
          "password": "newpassword",
          "password_confirmation": "newpassword"
        }
    
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/users", headers: headers, params: JSON.generate(data)
    
        expect(response).to have_http_status(422)
    
        error = JSON.parse(response.body, symbolize_names: true)
    
        expect(error).to be_a(Hash)
        expect(error).to have_key(:errors)
        expect(error[:errors]).to eq(["Email has already been taken"])
      end
    end
    
    context "when required fields are left blank" do
      it "returns a 422 Unprocessable Entity status" do
        data = {
          "email": "",
          "password": "password",
          "password_confirmation": "password"
        }
    
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/users", headers: headers, params: JSON.generate(data)
    
        expect(response).to have_http_status(422)
    
        error = JSON.parse(response.body, symbolize_names: true)
    
        expect(error).to be_a(Hash)
        expect(error).to have_key(:errors)
        expect(error[:errors]).to eq(["Email can't be blank"])
      end
    end
  end
end