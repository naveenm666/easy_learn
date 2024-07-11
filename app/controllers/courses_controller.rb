class CoursesController < ApplicationController
  before_action :set_tutor, except: :buy 
  before_action :set_course, only: [:buy]


  def index
    @courses = @tutor.courses
  end

  def show
    @course = @tutor.courses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Course not found."
    redirect_to tutor_courses_path(@tutor)
  end

  def new
    @course = @tutor.courses.build
  end

  def create
    @course = @tutor.courses.build(course_params)

    if @course.save
      redirect_to tutor_courses_path(@tutor), notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def buy
    @course = Course.find(params[:id])
  
    if @course.free
      flash[:alert] = "This course is free. No payment required."
      redirect_to students_path
      return
    end
  
    if @course.price.nil? || @course.price <= 0
      flash[:alert] = "Invalid course price."
      redirect_to students_path
      return
    end
  
    amount = (@course.price * 100).to_i
    receipt_id = "order_rcptid_#{@course.id}_#{current_student.id}"
  
    begin
      order = Razorpay::Order.create(
        amount: amount,
        currency: 'INR',
        receipt: receipt_id
      )

      @order_id = order.id

      current_student.transactions.create!(
        course: @course,
        order_id: @order_id,
        payment_id:'nill',
        status: 'pending'
      )

    rescue Razorpay::Error => e
      Rails.logger.error "Razorpay Error: #{e.message}"
      flash[:alert] = "Error creating Razorpay order: #{e.message}"
      redirect_to students_path
    end
  end
   
  private

  def set_tutor
    @tutor = Tutor.find(params[:tutor_id])
  end

  def course_params
    params.require(:course).permit(:title, :technologies, :duration, :table_of_contents, :course_type, :price, :free)
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
