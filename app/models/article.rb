class Article < ApplicationRecord

  mount_uploader :image, ImageUploader

	validates :title, presence: true, length: { minimum: 5}

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
		  text.downcase.split.uniq
    end
end
