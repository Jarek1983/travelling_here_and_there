class Message < ApplicationRecord

  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

end
