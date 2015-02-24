class Promotion < ActiveRecord::Base
  belongs_to :category

  scope :actual, -> { where('start_at < ? AND end_at > ?', Time.now, Time.now) }
end
