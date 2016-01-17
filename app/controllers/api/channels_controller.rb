class API::ChannelsController < API::BaseController
  before_action :set_channel, only: [:show, :update, :destroy]

  def index
    channels = API::ChannelPipeline.perform(Channel.order(name: :asc), params)
    render json: {channels: channels.as_json, meta: channels.meta}
  end

  def show
    render json: @channel
  end

  def create
    channel = Channel.new(channel_params)

    if channel.save
      render json: channel, status: :created
    else
      render json: {errors: channel.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: {errors: @channel.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @channel.destroy
    head :no_content
  end

  private

  def set_channel
    @channel = Channel.find_by(id: params[:id])

    unless @channel
      render json: {error: 'Channel #%s not found' % params[:id]}, status: :not_found
    end
  end

  def channel_params
    params.require(:channel).permit(:name)
  end
end
