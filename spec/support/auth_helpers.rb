module AuthHelpers
  def login_and_get_token(user)
    post sign_in_users_path, params: {
      user: {
        email: user.email,
        password: user.password
      }
    },
    headers: { "ACCEPT" => "application/json" }
    unless response.status == 200
      puts "Login failed with status #{response.status}"
      puts "Response body: #{response.body}"
      raise "login failed in test helper"
    end
        JSON.parse(response.body)["token"]
  end
  
  def auth_headers_for(user)
    token = login_and_get_token(user)
    {
      "Authorization" => "Bearer #{token}",
      "ACCEPT" => "application/json"
    }
  end
end

    