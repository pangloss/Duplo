class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  belongs_to :organization

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  before_save :normalize_email
  after_create :send_welcome_email

  def full_name
    return "Unknown" if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}".strip
  end

  def display_name
    return "Unknown" if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}".strip
  end

  def active_posts_count
    posts.where(published: true).count
  end

  def published_posts_count
    posts.where(published: true).count
  end

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: false) }

  def excerpt(length = 100)
    return "" if content.blank?
    content.truncate(length)
  end

  def summary(length = 100)
    return "" if content.blank?
    content.truncate(length)
  end
end