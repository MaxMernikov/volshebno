class Promotion < ActiveRecord::Base
  belongs_to :category

  scope :actual, -> { where('start_at < ? AND end_at > ?', Time.now, Time.now) }

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
