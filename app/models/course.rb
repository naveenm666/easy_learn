class Course < ApplicationRecord
  belongs_to :tutor

  validates :title, :technologies, :table_of_contents, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :free_or_paid, presence: true, inclusion: { in: %w(free paid) }

  validates :price, presence: true, numericality: { greater_than: 0 }, if: :paid_course?

  def paid_course?
    free_or_paid == 'paid'
  end
  
  def duration_months
    duration / 30
  end

  def duration_days
    duration % 30
  end

  def duration=(value)
    self[:duration] = value.to_i
  end

  def formatted_duration
    "#{duration_months} months #{duration_days} days"
  end
end
