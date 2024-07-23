class TransactionMailer < ApplicationMailer
  def expiry_notification(student, course)
    @student = student
    @course = course
    mail(to: @student.email, subject: "Your course is about to expire")
  end
end
