class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

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
end
