class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :check_for_expiring_transactions, if: :student_signed_in?


  protected

  def configure_permitted_parameters
    if resource_class == Student
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :education_qualification])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :education_qualification])
    elsif resource_class == Tutor
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone,:education_qualification, :profession, :work_experience ])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone,:education_qualification, :profession, :work_experience])
    end
  end

  # def check_for_expiring_transactions
  #   expiring_transactions = current_student.transactions.where('created_at >= ?', 5.minutes.ago).select do |transaction|
  #     transaction.time_until_expiration <= 1.minute
  #   end

  #   if expiring_transactions.any?
  #     expiring_courses = expiring_transactions.map { |transaction| transaction.course.title }.join(', ')
  #     flash[:alert] = "The following course transactions are about to expire in less than a minute: #{expiring_courses}"
  #   end
  # end
end
