class StudentsController < ApplicationController
  before_action :authenticate_student!

  def index
    @courses = Course.all
  end

  def create_razorpay_order
    begin
      # Fetch the course
      course = Course.find(params[:course_id])

      # Check if the course is free
      if course.free
        flash[:alert] = "This course is free. No payment required."
        redirect_to students_path
        return
      end

      # Ensure price is present and valid
      if course.price.nil? || course.price <= 0
        flash[:alert] = "Invalid course price."
        redirect_to students_path
        return
      end

      # Calculate the amount in paise (for Razorpay)
      amount = (course.price * 100).to_i
      receipt_id = "order_rcptid_#{course.id}_#{current_student.id}"

      # Create the Razorpay order
      order = Razorpay::Order.create(
        amount: amount,
        currency: 'INR',
        receipt: receipt_id
      )
      # Assuming Razorpay order creation is successful, pass order_id to view
      @order_id = order.id

      # Assuming payment is successful, update enrollment or flag
      # Example: Enroll the student in the course
      Enrollment.create(student_id: current_student.id, course_id: course.id)

      flash[:notice] = "Payment successful. You are now enrolled in #{course.title}."

    rescue Razorpay::Error => e
      flash[:alert] = "Error creating Razorpay order: #{e.message}"
      redirect_to students_path
    end
  end
end
