class Gossip < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :likes
  has_many :likers, through: :likes, source: :user
end
