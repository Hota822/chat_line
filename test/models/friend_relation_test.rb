require 'test_helper'

class FriendRelationTest < ActiveSupport::TestCase
  def setup
    user = users(:michael)
    other_user = users(:lana)
    @relation = FriendRelation.new(user_id: user.id,
                                   friend_id: other_user.id)
    @relation_reverse = FriendRelation.new(user_id: other_user.id,
                                            friend_id: user.id)
  end

  test "should be valid" do
    assert @relation.valid?
    assert @relation_reverse.valid?
  end

  test "should not be blank" do
    @relation.user_id = nil
    assert_not @relation.valid?
    @relation_reverse.friend_id = nil
    assert_not @relation_reverse.valid?
  end
end
