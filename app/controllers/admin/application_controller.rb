class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def authorize_user!
    redirect_to(emergencies_path) unless current_user.admin?
  end
end
