class CoursePurchaseNotificationJob < ApplicationJob
  queue_as :default

  def perform(student, course)
    CoursePurchaseMailer.with(student: student, course: course).course_purchase_successful.deliver_now
  end
end
