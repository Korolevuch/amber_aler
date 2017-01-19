class EmergenciesController < ApplicationController
  before_action :find_emergency, only: [:edit, :update, :show, :destroy,            :only_author_and_editor!, :add_editor]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :only_author_and_editor!, only: [:edit, :update, :destroy]

  def new
    @emergency = Emergency.new
  end

  def create
    @emergency = Emergency.new(page_params)
    @emergency.user = current_user
    if @emergency.save
      redirect_to emergencies_path
    else
      render :new
    end
  end

  def index
    @emergency_queries = EmergencyQuery.(params)
  end

  def edit; end

  def update
    if @emergency.update(page_params)
      redirect_to emergencies_path
    else
      render :edit
    end
  end

  def show
    @message = Message.new(emergency: @emergency)
    @messages = @emergency.messages.includes(:user).page(params[:page]).per(5)
  end

  def destroy
    if @emergency.user == current_user
       @emergency.destroy
      redirect_to emergencies_path ,flash: {error: 'Emergency was daleted'}
    else
      @emergency.users.delete(current_user)
      redirect_to emergencies_path, flash: {error: 'You lost rigst to edit the emergeny'}
    end
  end

  def add_editor
    if AddEditor.(@emergency, params)
      redirect_to emergency_path(@emergency), flash: {ssacces: 'You add new editor to your emergency'}
    else
      redirect_to emergency_path(@emergency), flash: {error: 'User not found'}
    end
  end

  private

  def only_author_and_editor!
    unless @emergency.user == current_user || @emergency.users.include?(current_user)
      redirect_to emergencies_path, flash: {error: 'Only author and editor can update emergency'}
    end
  end

    def page_params
      params[:emergency].permit(:title, :description)
    end

    def find_emergency
      @emergency = Emergency.find(params[:id])
    end
end
