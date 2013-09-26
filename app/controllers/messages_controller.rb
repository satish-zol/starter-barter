class MessagesController < ApplicationController
  #Method for declining the proposal who applied to job. 
  def message_received
  	  		
  	@received_messages = Message.where('receiver_id = ?', current_user.id)
  	@show_received_messages = []
  	@received_messages.each do|message|
  		@show_received_messages << message
  	end
  end

  def message_show
    @show_message = Message.find(params[:id])
    @show_message.update_attributes(:read_at => DateTime.now )
  end
  
  # DELETE Message
  def delete_message
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Message was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
end
