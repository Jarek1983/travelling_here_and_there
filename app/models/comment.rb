class Comment < ApplicationRecord

  validates :body, presence: true, length: { in: 6..30 }
  belongs_to :article, counter_cache: true 
  belongs_to :user
  has_many :grades
  has_many :users
  has_many :users, through: :grades
  
end
