class MessagesController < ApplicationController
  before_action :find_message, only: [:edit, :update, :destroy]

  def create
    @message = Message.new(message_params)
    @message.emergency_id = params[:emergency_id]
    @message.user = current_user
    if @message.save
      redirect_to emergency_path(@message.emergency_id)
    else
      render "emergencies/show"
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to emergency_path(@message.emergency_id)
    else
      render :edit
    end
  end

  def destroy
    if @message.destroy
      redirect_to emergency_path(@message.emergency_id)
    else
      redirect_to emergency_path(@message.emergency_id), flash: {error: 'Something went wrong'}
    end
  end

  private
  def message_params
    params.require(:message).permit(:text, :claim_closed)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end
