class CoursesController < ApplicationController
  before_action :set_tutor

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

  private

  def set_tutor
    @tutor = Tutor.find(params[:tutor_id])
  end

  def course_params
    params.require(:course).permit(:title, :technologies, :duration, :table_of_contents, :course_type, :price, :free)
  end
end
