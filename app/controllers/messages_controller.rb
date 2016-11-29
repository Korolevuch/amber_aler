class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :find_emergency, only: [:index, :create]
  before_action :find_message, only: [:edit, :update, :destroy]

  def create
    @message = @emergency.messages.build(messages_params)
    @message.user_id = current_user.id
    if @message.save
      flash[:notice] = 'Saved'
    else
      flash[:error] = 'Error'
    end
    redirect_to(emergency_path(@emergency))
  end

  def edit; end

  def update
     if @message.update(messages_params)
      flash[:notice] = "Updated"
    else
      flash[:error] = 'Error'
    end
      redirect_to(emergency_path(@message.emergency))
  end

  def destroy
    if @message.destroy
      flash[:notice] = "Message is destroy"
    else
      flash[:error] = 'Error'
    end
      redirect_to(emergency_path(@message.emergency))
  end

  private

  def messages_params
    params.require(:message).permit(:text, :claim_closed)
  end

  def find_emergency
    @emergency = Emergency.find(params[:emergency_id])
  end

  def find_message
    @message = Message.find(params[:id])
  end


end
