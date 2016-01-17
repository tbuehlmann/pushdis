class API::ChannelPipeline < API::BasePipeline
  use Lappen::Filters::Equal, :id, :name, :messages_count, :last_message_at, :created_at, :updated_at
  use Lappen::Filters::Orderer, :id, :name, :messages_count, :last_message_at, :created_at, :updated_at, reorder: true
  use Lappen::Filters::Comparable, :id, :messages_count
  use Lappen::Filters::Comparable, :created_at, :updated_at, parser: DateTime
end
