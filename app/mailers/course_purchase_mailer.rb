class CoursePurchaseMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def course_purchase_successful
    @student = params[:student]
    @course = params[:course]
    mail(to: @student.email, subject: 'Course Purchase Confirmation')
  end
end
