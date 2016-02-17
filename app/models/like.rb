class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user
end
