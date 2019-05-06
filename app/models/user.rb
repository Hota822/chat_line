class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save {self.email.downcase!}
  validates :name, presence: true, length:{ maximum: 30},
                   uniqueness: true
  validates :email, presence: true, length:{ maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: true}
  has_secure_password
  validates :password, presence: true, length: {minimum: 8}

  #渡され文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #送られているフレンドリクエストを返す
  def friend_request
    Friendship.where("request_id=?", id)
  end

  #友達の一覧を返す
  def friend_list
    Friendship.where("friend_id=?", id)
  end

  #渡されたユーザーが友達の場合、Trueを返す
  def friend?(user)
    #friend_list.include?(user)
  end
end
