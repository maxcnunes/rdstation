class PipedriveConfigsController < ApplicationController
  before_filter :logged_in?

  def index
    @pipedrive_config = PipedriveConfig.find_or_initialize_by(user_id: current_user.id, key: PipedriveConfig::KEYS[:app_key])
  end
  
  def app_key
    paramas_find_or_create = { user_id: current_user.id, key: PipedriveConfig::KEYS[:app_key] }
    
    @pipedrive_config = PipedriveConfig.where(paramas_find_or_create).first || PipedriveConfig.new(paramas_find_or_create)
    @pipedrive_config.value = params[:pipedrive_config][:value]

    respond_to do |format|
      if @pipedrive_config.save
        format.html { redirect_to pipedrive_configs_url, notice: 'Pipedrive key was successfully saved.' }
        format.json { render status: :success, location: pipedrive_configs_path }
      else
        format.html { render action: 'index' }
        format.json { render json: @pipedrive_config.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @pipedrive_config = PipedriveConfig.where(user_id: current_user.id, key: PipedriveConfig::KEYS[:app_key]).first
    @pipedrive_config.destroy
    respond_to do |format|
      format.html { redirect_to pipedrive_configs_url, notice: 'Pipedrive was successfully disabled.' }
      format.json { head :no_content }
    end
  end
end
