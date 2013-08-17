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
    def stub_pipedrive_requests
      controller.stub(:current_pipedrive_key).
        and_return(FactoryGirl.create(:pipedrive_config, user: current_user))
      
      Pipedrive::PersonField.any_instance.stub(:create).
        and_return({"data"=> {"id"=> 3 }})

      Pipedrive::PersonField.any_instance.stub(:find).
        and_return({"data"=> {"key"=> "819dea5b6358897ed5bbc8b85d1defb14fabcc8b" }})
    end

    describe "with valid params" do

      it "stores the Pipedrive app_key" do
        stub_pipedrive_requests
        valid_params = {:pipedrive_config => { value: valid_app_key }}
        expect {
          post :app_key, valid_params
        }.to change(PipedriveConfig.where(key: PipedriveConfig::KEYS[:app_key]), :count).by(1)
      end

      it "generates Pipedrive custom fields" do
        stub_pipedrive_requests
        
        custom_fields_pipedrive_configs = [
          PipedriveConfig::KEYS[:custom_field_job], 
          PipedriveConfig::KEYS[:custom_field_website]]

        valid_params = {:pipedrive_config => { value: valid_app_key }}
        expect {
          post :app_key, valid_params
        }.to change(PipedriveConfig.where(key: custom_fields_pipedrive_configs), :count).by(2)
      end
    end

    describe "with invalid params" do
      it "responds with unprocessable entity status" do
        stub_pipedrive_requests
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