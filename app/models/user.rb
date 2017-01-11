class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :games

  attr_accessor :rank

  def oponents_to_select
    User.where("id != ?", self.id).all.map{ |user| [user.email, user.id] }
  end

  def self.leaderborad
    users =  User.all.order("score DESC")
    rank = 0
    users.each { |user| rank += 1; user.rank = rank }
    users
  end
end
