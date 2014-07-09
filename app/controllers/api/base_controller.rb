class Api::BaseController < ApplicationController

  before_action :restrict_access

  private

  def restrict_access
    api_key = ApiKey.find_by_access_token(params[:access_token])
    if api_key
      @user = api_key.user
    else
      head :unauthorized
    end
  end

end
