class PersonController < BaseController
  get "/" do
    "slash!"
  end

  get "/me" do
    require_valid_acquia_user!
    "Hello, World!"
  end

  get "/person/:id" do
    "Individual person by ID = #{params[:id]}"
  end
end