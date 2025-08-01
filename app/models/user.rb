class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, uniqueness: true, length: { minimum:2,maximum: 20 }
  validates :introduction, length: { maximum: 50 }
  
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    authentication_keys: [:name]
  )

    has_many :post_images, dependent: :destroy
    has_many :books, dependent: :destroy
    has_one_attached :profile_image

    def get_profile_image
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [100, 100]).processed
    end
end
