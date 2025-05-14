require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:users) { create_list(:user, 3) }
  let(:user) { create(:user, password: "password123") }
  let(:headers) { auth_headers_for(user) }

  describe "GET /users" do
    context "when authenticated" do
      it "returns all the users" do
        get "/users" ,headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body))
      end
    end

    context "when not authenticated" do
      it "returns 401 Unauthorized" do
        get "/users"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /users" do
    let(:valid_params) do
      {
        user: {
          first_name: "Jane",
          surname: "Doe",
          email: "jane.doe@example.com",
          password: "password113",
          phone_no: "1234999890",
          role_id: 2
        }
      }
    end

    it "creates a new user without authentication" do
      post "/users", params: valid_params, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["email"]).to eq("jane.doe@example.com")
    end
  
  end

  describe "GET /users/:id" do
    context "when authenticated" do
      it "returns the user details" do
        get "/users/#{user.id}", headers: headers
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['email']).to eq(user.email)
      end
    end

    context "when not authenticated" do
      it "returns 401 Unauthorized" do
        get "/users/#{user.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when user does not exist" do
      it "returns 404 Not Found" do
        get "/users/999999", headers: headers
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User not found')
      end
    end
  end

  describe "PUT /users/:id" do
    let(:update_params) do
      {
        user: {
          first_name: "UpdatedName",
          surname: "UpdatedSurname",
          phone_no: "0987654321",
          password: "newpassword123"
        }
      }
    end

    context "when authenticated" do
      it "updates the user" do
        put "/users/#{user.id}", params: update_params, headers: headers
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['first_name']).to eq("UpdatedName")
      end
    end

    context "when not authenticated" do
      it "returns 401 Unauthorized" do
        put "/users/#{user.id}", params: update_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when updating with invalid parameters" do
      let(:invalid_update_params) do
        {
          user: {
            first_name: "",
            surname: "UpdatedSurname",
            phone_no: "abc",
            password: "short"
          }
        }
      end

      it "returns unprocessable entity for invalid parameters" do
        put "/users/#{user.id}", params: invalid_update_params, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("First name can't be blank", "Phone no is not a number")
      end
    end
  end

  # Test DELETE /users/:id
  describe "DELETE /users/:id" do
    context "when authenticated" do
      it "deletes the user" do
        delete "/users/#{user.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("User deleted successfully")
      end
    end

    context "when not authenticated" do
      it "returns 401 Unauthorized" do
        delete "/users/#{user.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when user does not exist" do
      it "returns 404 Not Found" do
        delete "/users/999999", headers: headers
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("User not found")
      end
    end
  end

end
