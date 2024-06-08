class TutorController < ApplicationController
  before_action :authenticate_tutor!
  def index
    @courses = current_tutor.courses
  end
end
