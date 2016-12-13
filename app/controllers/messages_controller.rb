class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :find_message, only: [:edit, :update, :destroy]

  def create
    @message = Message.new(message_params)
    @message.emergency_id = params[:emergency_id]
    @message.user_id = current_user.id
    if @message.save
      redirect_to emergency_path(@message.emergency_id)
    else
      render "emergencies/show"
    end
  end

  def edit; end

  def update
    if @message.update(message_params)
      redirect_to(emergency_path(@message.id))
    else
      render(:edit)
    end
  end

  def destroy
   if @message.destroy
    redirect_to(emergency_path(@message.emergency_id))
    flash.notice = "Message #{@message} is destroy"
  else
    redirect_to(emergency_path(@message.emergency_id))
    flash[:error] = "'Something went wrong'"
  end
end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:text, :claim_closed)
  end
end



