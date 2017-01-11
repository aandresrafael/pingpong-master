class Game < ActiveRecord::Base
  belongs_to :user
  has_one :oponent, class_name: 'User', foreign_key: 'oponent_id'
end
