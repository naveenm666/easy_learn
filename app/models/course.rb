class Course < ApplicationRecord
  belongs_to :tutor 
  accepts_nested_attributes_for :tutor  
  
  validates :title, presence: true
  validates :price, presence: true, if: -> { !free }
  validates :free, inclusion: { in: [true, false] }

  validates :duration, presence: true

  validates :tutor_id, presence: true
  
end
