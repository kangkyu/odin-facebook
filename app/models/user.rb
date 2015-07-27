class User < ActiveRecord::Base
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :friendships, -> { Friendship.accepted }
  has_many :friends, through: :friendships
  has_many :inverse_friendships, -> { Friendship.accepted }, 
            class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :pending_friendships, -> { Friendship.pending },
            class_name: "Friendship"
  has_many :pending_inverse_friendships, -> { Friendship.pending },
            class_name: "Friendship", foreign_key: "friend_id"
 

  #would this work? simplifies lot of views and more DRY 
  #has_many :friends, through: :inverse_friendships, source: :user 

  #dependent destroy
  has_many :posts
  has_many :comments
  has_many :likes

  private
    def send_welcome_email
      UserMailer.welcome_email(self).deliver
    end
end
