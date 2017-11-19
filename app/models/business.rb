class Business < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  
  has_many :reviews, -> { order(created_at: :desc) }

  validates :name, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true, numericality: { only_integer: true }, length: { is: 5 }
  validates :phone, presence: true, numericality: { only_integer: true }
  
  
  def average_rating
    return nil if reviews.size == 0
    
    (reviews.sum(:rating).to_f / reviews.size.to_f).round
  end
end