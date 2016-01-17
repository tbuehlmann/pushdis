class API::MessagePipeline < API::BasePipeline
  # TimeParser = Object.new.tap do |parser|
  #   def parser.parse(time_string)
  #     if time_string =~ /\A\d+\z/
  #       Time.at(time_string.to_i)
  #     else
  #       time_string
  #     end
  #   end
  # end

  use WithChannelNameFilter
  use Lappen::Filters::Equal, :id, :title, :channel_id, :created_at, :updated_at
  use Lappen::Filters::Orderer, :id, :title, :channel_id, :created_at, :updated_at, reorder: true
  use Lappen::Filters::Comparable, :id
  use Lappen::Filters::Comparable, :created_at, :updated_at, parser: DateTime
end
