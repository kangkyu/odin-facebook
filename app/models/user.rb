class User < ActiveRecord::Base
  # enable after setting up Sendgrid
  # after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # DRY by combining friendships and inverse friendships (same with pending)
  has_many :friendships, -> { Friendship.accepted }, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, -> { Friendship.accepted }, 
            class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :pending_friendships, -> { Friendship.pending },
            class_name: "Friendship", dependent: :destroy 
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :pending_inverse_friendships, -> { Friendship.pending },
            class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :pending_inverse_friends, through: :pending_inverse_friendships, source: :user
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  private
    def send_welcome_email
      UserMailer.welcome_email(self).deliver
    end
end
