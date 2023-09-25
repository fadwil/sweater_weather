require "rails_helper"

RSpec.describe "Sessions API", type: :request do
  describe "POST /api/v1/sessions" do
    context "with valid credentials" do
      it "returns the users api key" do
        user = create(:user)
        
        params = {
          "email": user.email,
          "password": user.password
        }

        headers = { "CONTENT_TYPE" => "application/json" }
        
        post "/api/v1/sessions", headers: headers, params: JSON.generate(params)

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["data"]["type"]).to eq("users")
        expect(JSON.parse(response.body)["data"]["id"]).to eq(user.id.to_s)
        expect(JSON.parse(response.body)["data"]["attributes"]["email"]).to eq(user.email)
        expect(JSON.parse(response.body)["data"]["attributes"]["api_key"]).to eq(user.api_key)
      end
    end

    context "with invalid credentials" do
      it "returns a 400-level status code and error message" do
        user = create(:user)

        params = {
          "email": user.email,
          "password": "wrongpass"
        }

        headers = { "CONTENT_TYPE" => "application/json" }
        
        post "/api/v1/sessions", headers: headers, params: JSON.generate(params)
        expect(response).to have_http_status(400) 
        expect(JSON.parse(response.body)).to eq({ "error" => "Invalid credentials" })
      end
    end
  end
end
