class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  scope :accepted, -> { where(status: true) }
  scope :pending, -> { where(status: false) }

  #prevents duplicate entries if format is user_id, friend_id
  #does not stop duplicate when values are swapped
  validates_uniqueness_of :user_id, :scope  => :friend_id

  #supposed to prevent friending self, but not working 
  #validates :friend_id, exclusion: { in: %w(current_user.id)}
end
