class ApisController < ApplicationController

  def github_callback
    user = User.find_by(github_state: params[:state]) if params[:state]
    redirect_to root_path, notice: 'Invalid flow. Something is not right' unless user
    access_token = Apis::Github.get_access_token(user, params[:code])
    redirect_to root_path, notice: 'Invalid flow. Something is not right, could not get access token' unless access_token
    user.update_attributes(github_access_token: access_token, github_state: 'completed')
    redirect_to user_path(user)
  end

end