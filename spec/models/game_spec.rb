require 'spec_helper'

describe Game do
  describe '#validations' do
    let(:game) do
      Game.new(user_id: 1, opponent_id: 1, date_played: Date.today)
    end

    context 'validate score' do
      context 'when score is invalid' do
        before do
          game.user_score = 15
          game.opponent_score = 10
        end

        it 'should be invalid' do
          game.save
          expect(game.errors).to_not be_empty
        end
      end
      context 'when score is valid' do
        before do
          game.user_score = 21
          game.opponent_score = 10
        end

        it 'should be invalid' do
          game.save
          expect(game.errors).to be_empty
        end
      end
    end
  end

  describe '#update_ranking' do
    let(:user) { User.create!(email: "andres1@regalii.com", password: 'secret123') }
    let(:opponent) { User.create!(email: "andres@regalii.com", password: 'secret123') }

    context 'when user won the game' do
      let(:game) do
        Game.new(
          user_id: user.id,
          opponent_id: opponent.id,
          date_played: Date.today,
          user_score: 21,
          opponent_score: 10
        )
      end

      it 'should update the user ranking' do
        game.save
        expect(user.reload.score).to be(21)
      end
    end

    context 'when user lost the game' do
      let(:game) do
        Game.new(
          user_id: user.id,
          opponent_id: opponent.id,
          date_played: Date.today,
          user_score: 10,
          opponent_score: 21
        )
      end

      it 'should not update the user ranking' do
        game.save
        expect(user.reload.score).to be_zero
      end
    end

  end
end
