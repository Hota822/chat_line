class User < ApplicationRecord
  has_many :friend_requests, dependent: :destroy
  has_many :friend_relations_to, class_name: 'FriendRelation',
                                  foreign_key: 'user_id',
                                  dependent: :destroy
  has_many :friendships_to, through: :friend_relations_to, source: :friend
  has_many :friend_relations_from, class_name: 'FriendRelation',
                                  foreign_key: 'friend_id',
                                  dependent: :destroy
  has_many :friendships_from, through: :friend_relations_from, source: :user
  def friendships
    #申請出された　＋　申請出した
    friendships_from + friendships_to
  end
  has_many :user_talkroom_relations, dependent: :destroy
  has_many :talk_rooms, through: :user_talkroom_relations
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
  def all_friend_request
    FriendRequest.where("request_user_id=?", id)
  end

  #与えられたユーザーとの関係を返す
  def user_relation(other_user)
    case
    when friend?(other_user) then return 'friend'
    when received_request?(other_user) then return 'received_request'
    when already_sent_request?(other_user) then return 'already_request'
    when self == other_user then return 'current_user'
    else
        return 'non_friend'
    end
  end

  #渡されユーザーから既に申請が来ている場合、True
  def received_request?(user)
    !(user.friend_requests.where("request_user_id=?", id).count == 0)
  end

  #渡されたユーザーに既に申請を送っていた場合True
  def already_sent_request?(user)
    !(friend_requests.where("request_user_id=?", user.id).count == 0)
  end

  #渡されたユーザーがフレンドのとき、True
  def friend?(user)
    friendships.include?(user)
  end

  #渡されたユーザーからのフレンド申請を削除する
  def delete_friendrequest(user)
    user.friend_requests.find_by(request_user_id: self.id).destroy
  end

  #渡されたユーザーを友達に追加する
  def add_friend(user)
    delete_friendrequest(user)
    friendships_to << user
  end

  #友達の一覧を返す
  def friend_list
    Friendship.where("friend_id=?", id)
  end
end
