class API::MessagesController < API::BaseController
  def index
    messages = API::MessagePipeline.perform(Message.order(created_at: :desc), params)
    render json: {messages: messages.as_json, meta: messages.meta}
  end

  def show
    message = Message.find_by(id: params[:id])

    if message
      render json: message
    else
      render json: {error: 'Message #%s not found' % params[:id]}, status: :not_found
    end
  end

  def create
    message = Message.new(message_params).extend(WithChannelUpdater)

    if message.save
      render json: message, status: :created
    else
      render json: {errors: message.errors}, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :subtitle, :channel_id)
  end
end
