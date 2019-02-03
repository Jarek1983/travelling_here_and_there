class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :number, uniqueness: {scope: :comment, message: 'already voting'} #zasięg dla komentarzy

end