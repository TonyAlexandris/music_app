require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    valid_user = FactoryBot.build(:user)
    no_pass_user = FactoryBot.build(:user, password: "")
    invalid_user = FactoryBot.build(:user, password: "123")
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        expect(no_pass_user).to_not be_valid
      end

      it "validates that the password is at least 6 characters long" do
        expect(invalid_user).to_not be_valid
      end
    end

    context "with valid params" do
      it "redirects user to bands index on success" do
        post :create, params: { user: { email: "a@b.com", password: "qwerty" } }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end
