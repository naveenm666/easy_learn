class Transaction < ApplicationRecord
  belongs_to :student
  belongs_to :course
  before_save :set_expires_at


  def expired?
    if course.validity.present? && created_at.present?
      validity_duration = Course.validities[course.validity.to_sym]
      if validity_duration.present?
        created_at + validity_duration < Time.now
      else
        false
      end
    else
      false
    end
  end

  def self.check_and_send_expiry_emails
    puts "Initiating notification mails process..."
    current_time = Time.current

    transactions = Transaction.where('expires_at <= ?', Time.now + 1.day).where(notified: false).includes(:course, :student)

    transactions.find_each do |transaction|
      puts "transaction: #{transaction}"
      puts "Sending notification for transaction: #{transaction.id}"
      TransactionMailer.expiry_notification(transaction.student, transaction.course).deliver_now
      transaction.update(notified: true)
    end
    puts "Completed sending notification mails"
  end

  private

  def set_expires_at
    if course.validity.present? && created_at.present?
      validity_duration = Course.validities[course.validity.to_sym]
      if validity_duration.present?
        self.expires_at = created_at + validity_duration
      end
    end
  end

end
