class Business < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  validates :name, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true, numericality: { only_integer: true }, length: { is: 5 }
  validates :phone, presence: true, numericality: { only_integer: true }
  
  has_many :reviews
end