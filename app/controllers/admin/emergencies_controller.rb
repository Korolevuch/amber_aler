class Admin::EmergenciesController < Admin::ApplicationController
  before_action :find_emrgency, only: [:destroy]

  def destroy
    @emergency.destroy
    redirect_to(emergencies_path)
  end

  private

  def find_emrgency
    @emergency = Emergency.find(params[:id])
  end

end
