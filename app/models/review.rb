class Review < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  
  belongs_to :business
  belongs_to :user
  
  delegate :full_name, :reviews_count,  to: :user, prefix: :user 
  
  validates :content, presence: true
  validates :rating, presence: true
  
end