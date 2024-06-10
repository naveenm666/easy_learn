class CoursesController < ApplicationController
  before_action :authenticate_tutor!

  def index
    @courses = current_tutor.courses
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_tutor.courses.build(course_params)

    if @course.save
      redirect_to courses_path, notice: 'Course created successfully.'
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :technologies, :duration, :table_of_contents, :free_or_paid, :price)
  end
end
