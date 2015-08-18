class Like < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :post_id, uniqueness: {scope: :user_id}
end
