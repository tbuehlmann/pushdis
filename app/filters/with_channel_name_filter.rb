class WithChannelNameFilter < Lappen::Filter
  def perform(scope, params = {})
    channel_names = channel_names(params)
    add_meta_information(channel_names)

    if channel_names.any?
      channel_ids = channel_ids_for_channel_names(channel_names)
      scope.where(channel_id: channel_ids)
    else
      scope
    end
  end

  private

  def channel_names(params)
    @channel_names ||= begin
      channels = params[:filter]&.[](:channels)

      case channels
      when Array
        channels
      when String
        channels.split(',')
      else
        []
      end
    end
  end

  def channel_ids_for_channel_names(channel_names)
    Channel.where(name: channel_names).pluck(:id)
  end

  def add_meta_information(channel_names)
    if channel_names.any?
      meta[:equal] ||= {}
      meta[:equal][:channels] = channel_names
    end
  end
end
