class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  scope :accepted, -> { where(status: true) }
  scope :pending, -> { where(status: false) }
  validate :friend_self
  validate :friendship_exists

  def friend_self
    if friend_id == user_id
      self.errors[:base] << "Can't add yourself!"
    end
  end

  def friendship_exists
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id}",
      "user_id = #{friend_id} AND friend_id = #{user_id}"]
    if Friendship.where(combinations.join(' OR ')).exists?
      self.errors.add(:user_id, 'Already friends!')
    end
  end

end

