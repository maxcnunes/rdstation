require 'spec_helper'

describe PipedriveConfigsController do
  let(:current_user) { FactoryGirl.create(:user) }
  let(:valid_app_key) { "09a2kda8a30d92893lfs987d78a9" }

  before(:each) do
    session[:user_id] = current_user.id
  end
  
  describe "GET index" do
    it "load index page with pipedrive configuration" do
      get :index
      response.should be_success
      assigns(:pipedrive_config).should_not be_nil
    end
  end

  describe "POST app_key" do
    describe "with valid params" do
      it "stores the Pipedrive app_key" do
        valid_params = {:pipedrive_config => { value: valid_app_key }}
        expect {
          post :app_key, valid_params
        }.to change(PipedriveConfig, :count).by(1)
      end
    end

    describe "with invalid params" do
      it "responds with unprocessable entity status" do
        invalid_params = {:pipedrive_config => { value: ""}}
        post :app_key, invalid_params
        response.should be_success
      end
    end
  end
  
  describe "DELETE destroy" do
    def create_pipedrive
      FactoryGirl.create(:pipedrive_config, user_id: current_user.id, key: PipedriveConfig::KEYS[:app_key])
    end
  
    it "destroys the requested app_key" do
      create_pipedrive
      expect {
        delete :destroy
      }.to change(PipedriveConfig, :count).by(-1)
    end

    it "redirects to the people list" do
      create_pipedrive
      delete :destroy
      response.should redirect_to(pipedrive_configs_url)
    end
  end
end