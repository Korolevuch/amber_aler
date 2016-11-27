class EmergenciesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :find_emergency, only: [:destroy, :show, :edit, :update]
  before_action :only_author!, only: [:edit, :update, :destroy]

  def index
    @emergencies = Emergency.all
  end

  def new; end

  def show; end

  def create
    @emergency = Emergency.create(emergency_params)
    @emergency.user = current_user
    @emergency.save ? redirect_to(emergency_path(@emergency)) : render(:new)
  end

  def edit; end

  def update
    if @emergency.update(emergency_params)
      flash[:notice] = "#{@emergency.title} is update"
      redirect_to(emergency_path(@emergency))
    else
      render(:edit)
    end
  end

  def destroy
    @emergency.destroy
    flash.notice = "Emergency #{@emergency.title} is destroy"
    redirect_to(emergencies_path)
  end


  private

   def find_emergency
    @emergency = Emergency.find(params[:id])
  end

  def emergency_params
    params.require(:emergency).permit(:title, :description)
  end

  def only_author!
    if @emergency.user != current_user
      flash[:error] = 'Permition denied'
      redirect_to(emergencies_path)
    end
  end

end
