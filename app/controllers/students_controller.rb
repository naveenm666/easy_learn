class StudentsController < ApplicationController
  before_action :authenticate_student!

  def index
    @courses = Course.all
  end

 
end
