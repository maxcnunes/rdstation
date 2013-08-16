class PipedriveConfigsController < ApplicationController
  before_filter :logged_in?

  def create
    @pipedrive_config = PipedriveConfig.new(pipedrive_config_value_param)
    @pipedrive_config.key = PipedriveConfig::KEYS[:app_key]
    @pipedrive_config.user = current_user

    if @pipedrive_config.save
      session[:pipedrive_key] = @pipedrive_config.key
      render json: @pipedrive_config, status: :created
    else
      render json: @pipedrive_config.errors, status: :unprocessable_entity
    end
  end

  private

    def pipedrive_config_value_param
      params.require(:pipedrive_config).permit(:value)
    end
end
