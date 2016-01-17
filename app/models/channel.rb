class Channel < ActiveRecord::Base
  has_many :messages, dependent: :delete_all

  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validates :name, length: {maximum: 16}
  validates :name, format: {with: /\A[a-z0-9_-]*\z/, message: 'is invalid, allowed characters are: a-z, 0-9, _, -'}

  max_paginates_per 250

  def name=(name)
    name.respond_to?(:downcase) ? super(name.downcase) : super
  end
end
