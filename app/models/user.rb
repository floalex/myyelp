class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :full_name, presence: true
  validates :zipcode, presence: true

  has_secure_password validations: false

  def reviews_count
    reviews.count
  end
end