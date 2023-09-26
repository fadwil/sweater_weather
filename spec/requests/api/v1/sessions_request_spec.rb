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

        parsed = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(parsed["data"]["type"]).to eq("users")
        expect(parsed["data"]["id"]).to eq(user.id.to_s)
        expect(parsed["data"]["attributes"]["email"]).to eq(user.email)
        expect(parsed["data"]["attributes"]["api_key"]).to eq(user.api_key)
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
        parsed = JSON.parse(response.body)

        expect(response).to have_http_status(400) 
        expect(parsed).to eq({ "error" => "Invalid credentials" })
      end
    end
  end
end
