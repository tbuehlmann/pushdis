class Message < ActiveRecord::Base
  belongs_to :channel

  validates :channel, :title, presence: true
  validates :title,    length: {maximum:  64}
  validates :subtitle, length: {maximum: 128}

  max_paginates_per 250
end
