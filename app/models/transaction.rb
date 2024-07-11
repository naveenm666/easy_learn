class Transaction < ApplicationRecord
  belongs_to :student
  belongs_to :course

  def expired?
    created_at < 5.minutes.ago
  end
end
