class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :comments

  validates :number, presence: true

end