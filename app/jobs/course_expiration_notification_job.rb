class CourseExpirationNotificationJob < ApplicationJob
  queue_as :default

  def perform(student, course)
    CourseExpirationMailer.with(student: student, course: course).course_expiration_mail.deliver_now
  end
end
