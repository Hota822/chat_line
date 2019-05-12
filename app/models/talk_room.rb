class TalkRoom < ApplicationRecord
  has_many :user_talkroom_relations
  has_many :users, through: :user_talkroom_relations
  has_many :talks

  #トークルームに招待する
    def invite(other_user)
      users <<  other_user
    end

  #トークルームからキックする
    def kick(other_user)
      usres.find_by(id: other_user.id).destroy
    end

  #トークに参加しているとき、Trueを返す
    def talker?(user)
      users.include?(user)
    end

end
