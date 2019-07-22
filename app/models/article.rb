class Article < ApplicationRecord

  mount_uploader :image, ImageUploader
  mount_uploader :image_second, ImageUploader
  mount_uploader :image_third, ImageUploader
  mount_uploader :image_fourth, ImageUploader
  mount_uploader :image_fifth, ImageUploader
  mount_uploader :image_sixth, ImageUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

	validates :title, presence: true, length: { minimum: 5}
  validates :text, presence: true, length: { minimum: 5}

	has_many :comments, dependent: :destroy
	belongs_to :user

  has_many :likes
  has_many :users, through: :likes 
  has_many :users, through: :grades

  scope :published, -> {where(published: true)} 
  scope :most_commented, -> {order(comments_count: :desc).first}

  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)
    super(value)
  end

  def css_class
    if published?
      'normal'
    else
      'unpublished'
    end
  end

  private

    def sanitize_tags(text)
		  text.capitalize.split.uniq
    end
end
