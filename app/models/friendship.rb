class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  scope :accepted, -> { where(status: true) }
  scope :pending, -> { where(status: false) }
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :status, :inclusion => { :in => [true, false] }
  validate :friend_self
  validate :friendship_exists, if: Proc.new { |a| a.user_id? && a.friend_id? }

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

