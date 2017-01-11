class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id'

  validates_presence_of :user_id, :opponent_id, :date_played, :user_score,
    :opponent_score
  before_save :validate_score
  after_save :update_ranking


  def score
    "#{user_score} - #{opponent_score}"
  end

  def result
    won? ? "W" : "L"
  end

  def won?
    user_score > opponent_score
  end

  private

  def validate_score
    diff = user_score - opponent_score
    return true  if (user_score == 21 || opponent_score == 21) && diff >= 2
    errors.add(:base, "Invalid score. They are games to 21. Each game needs to be won by a two point margin.")
    false
  end

  def update_ranking
    return unless won?
    importance = opponent.score > user.score ? 1.5 : 1.0
    user.score += user_score * importance
    user.save!
  end
end
