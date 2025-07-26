class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :body, length: { maximum: 200 },presence: true
  validate :image_type

  private

  def image_type
    return unless image.attached?

    unless image.content_type.in?(%w(image/jpeg image/jpg))
      errors.add(:image, 'はJPEG形式（.jpg）のみアップロード可能です')
    end
  end
end