class Business < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  validates :name, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :phone, presence: true
end