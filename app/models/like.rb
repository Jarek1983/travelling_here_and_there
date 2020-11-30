class Like < ApplicationRecord
	
  belongs_to :article, counter_cache: true 
  belongs_to :user

  validates :user, uniqueness: {scope: :article, message: 'already liked'}
end
