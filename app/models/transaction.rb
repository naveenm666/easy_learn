class Transaction < ApplicationRecord
  belongs_to :student
  belongs_to :course


  def expired?
    if course.validity.present? && created_at.present?
      validity_duration = Course.validities[course.validity.to_sym]
      if validity_duration.present?
        created_at + validity_duration < Time.now
      else
        false  # Handle cases where validity duration is not defined
      end
    else
      false  # Handle cases where course validity or creation time is not present
    end
  end

  def time_until_expiration
    (created_at + 5.minutes) - Time.current
  end
end
