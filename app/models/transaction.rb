class Transaction < ApplicationRecord
  belongs_to :student
  belongs_to :course

  def expired?
    created_at < 5.minutes.ago
  end

  def time_until_expiration
    (created_at + 5.minutes) - Time.current
  end
end
