class Category < ActiveRecord::Base
  has_many :promotions
end
