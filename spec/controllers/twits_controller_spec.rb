require 'rails_helper'

RSpec.describe TwitsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'

    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "GET #index" do
    it "returns http success when signed_in" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "redirects to sign_in page when user is not logged in" do
      sign_out @current_user
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST #create" do
    context "right data and user" do
      before(:each) do
        @twit_attributes = attributes_for(:twit, user: @current_user)
      end

      it "Twis has been created" do
        expect{
          post :create, params: { twit: @twit_attributes }
        }.to change(Twit, :count).by(1)
      end

      it "Twit has been created with right data" do
        post :create, params: { twit: @twit_attributes }
        expect(Twit.last).to have_attributes(@twit_attributes)
      end

      it "returns http success" do
        post :create, params: { twit: @twit_attributes }
        expect(response).to have_http_status(:success)
      end
    end

    context "missing data" do
      it "returns 4xx when data is wrong or nil" do
        @bad_twit_attributes = attributes_for(:twit, user: @current_user, content: " ")
        post :create, params: { twit: @bad_twit_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe "PUT #update" do
    context "right user updating" do
      before(:each) do
        @new_twit_attributes = attributes_for(:twit)
        @twit = create(:twit, user: @current_user)
        put :update, params: { id: @twit.id, twit: @new_twit_attributes }
      end

      it "twit updated" do
        expect(Twit.last).to have_attributes(@new_twit_attributes)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "not updated when wrong data" do
      it "returns unprocessable_entity when data is wrong" do
        @wrong_new_twit_attributes = attributes_for(:twit, content: " ")
        @twit = create(:twit, user: @current_user)
        put :update, params: { id: @twit.id, twit: @wrong_new_twit_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns 404 when Twit is not found" do
        @new_twit_attributes = attributes_for(:twit)
        put :update, params: { id: 0, twit: @new_twit_attributes }
        expect(response).to redirect_to('/')
      end
    end

    context "user cannot update" do
      it "returns forbidden status" do
        @twit = create(:twit)
        @twit_attributes = attributes_for(:twit)
        put :update, params: { id: @twit.id, twit: @twit_attributes }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end


  describe "DELETE #destroy" do
    context "deleting twit" do
      it "returns http success" do
        @twit = create(:twit, user: @current_user)
        expect{
          delete :destroy, params: { id: @twit.id }
        }.to change(Twit, :count).by(-1)
      end

      it "returns status success when deleted correctly" do
        @twit = create(:twit, user: @current_user)
        delete :destroy, params: { id: @twit.id }
        expect(response).to have_http_status(:success)
      end

      it "not found when cant find twit" do
        delete :destroy, params: { id: 0 }
        expect(response).to redirect_to('/')
      end

      it "returns 403 when not current_user" do
        @twit = create(:twit)
        delete :destroy, params: { id: @twit.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
