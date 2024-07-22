class Course < ApplicationRecord
  belongs_to :tutor 
  accepts_nested_attributes_for :tutor  
  has_many :transactions
  has_many :students, through: :transactions
  
  validates :title, presence: true
  validates :price, presence: true, if: -> { !free }
  validates :free, inclusion: { in: [true, false] }
  enum validity: {
    five_minute: 5.minute,
    one_hour: 1.hour,
    one_day: 1.day,
    three_days: 3.day
  }

  validates :duration, presence: true

  validates :tutor_id, presence: true
  
end
