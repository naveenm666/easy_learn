class CourseExpirationMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def course_expiration_mail
    @student = params[:student]
    @course = params[:course]
    mail(to: @student.email, subject: 'Course Expiration Notification')
  end
end
