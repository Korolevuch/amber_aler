class EmergenciesController < ApplicationController
  include EmergencyHelper
  before_action :find_emergency, only: %i(edit update show destroy only_author_and_editor! add_editor)
  before_action :authenticate_user!, only: %i(new create edit update)
  before_action :only_author_and_editor!, only: %i(edit update destroy)

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
    if emergency_policy(@emergency).owner?
        @emergency.destroy
        redirect_to emergencies_path ,flash: { success: 'Emergency was daleted' }
    else
      @emergency.users.delete(current_user)
      redirect_to emergencies_path, flash: { error: 'You lost rights to edit the emergency' }
    end
  end

  def add_editor
    result = AddEditor.(@emergency, params)
    redirect_to emergency_path(@emergency), flash: result
  end

  private

  def only_author_and_editor!
    unless emergency_policy(@emergency).can_edit?
      redirect_to emergencies_path, flash: { error: 'Only author and editor can update emergency' }
    end
  end

  def page_params
    params.require(:emergency).permit(:title, :description)
  end

  def find_emergency
    @emergency = Emergency.find(params[:id])
  end
end
