require 'spec_helper'

describe PipedriveConfigsController do
  let(:current_user) { FactoryGirl.create(:user) }

  before(:each) do
    session[:user_id] = current_user.id
  end

  describe "POST create" do
    describe "with valid params" do
      it "stores the Pipedrive app_key" do
        valid_params = {:pipedrive_config => { value: "09a2kda8a30d92893lfs987d78a9" }}
        expect {
          post :create, valid_params
        }.to change(PipedriveConfig, :count).by(1)
      end
    end

    describe "with invalid params" do
      it "responds with unprocessable entity status" do
        invalid_params = {:pipedrive_config => { value: ""}}
        post :create, invalid_params
        response.status.should eql(422) #unprocessable_entity
      end
    end
  end
end