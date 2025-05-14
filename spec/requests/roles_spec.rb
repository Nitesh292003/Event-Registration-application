require 'rails_helper'

RSpec.describe "Roles", type: :request do
  let!(:roles) { create_list(:role, 3) } 
  let(:admin_role) { create(:user, role_id: 1) }
 
  


  let(:headers) { auth_headers_for(admin_role) }
  

  describe "GET /roles" do
    it "returns all roles" do
      get "/roles" ,headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
    end
  end

  describe "GET /roles/:id" do
    it "returns a specific role" do
      role = roles.first
      get "/roles/#{role.id}" ,headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(role.id)
    end

    it "returns 404 for non-existent role" do
      get "/roles/0" ,headers: headers
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "error" => "Role not found" })
    end
  end

  describe "POST /roles" do
    let(:valid_params) do
      {
        role: {
          role_type: "HR"
        }
      }
    end

    it "creates a new role" do
      post "/roles", params: valid_params, headers: { "ACCEPT" => "application/json" }
      expect(response). to have_http_status(:created)
      puts response.body
    end

    it "returns 422 for invalid role" do
      post "/roles", params: { role: { role_type: nil } }, headers: { "ACCEPT" => "application/json" }
      puts response.status
      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)
      expect(json).to have_key("role_type")
    end
  end

 


  describe "PUT /roles/:id" do
    it "updates the role" do
      role = roles.first
      put "/roles/#{role.id}", params: { role: { role_type: "UpdatedRole" } }, headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["role_type"]).to eq("UpdatedRole")
    end

    it "returns 422 if update is invalid" do
      role = roles.first
      put "/roles/#{role.id}", params: { role: { role_type: nil } }, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json).to have_key("role_type")
    end
  end

  describe "DELETE /roles/:id" do
    it "deletes the role" do
      role = create(:role)
      expect {
        delete "/roles/#{role.id}", headers: headers
      }.to change(Role, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
    
end
