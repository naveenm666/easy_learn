class TutorController < ApplicationController
  before_action :authenticate_tutor!
  def index
  end
end
