class Course < ApplicationRecord
  belongs_to :tutor 
  has_many :enrollments
  has_many :students, through: :enrollments
  accepts_nested_attributes_for :tutor  
  
  validates :title, presence: true
  validates :price, presence: true, if: -> { !free }
  validates :free, inclusion: { in: [true, false] }

  validates :duration, presence: true

  validates :tutor_id, presence: true
  
end
