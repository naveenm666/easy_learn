class ChangeDurationToStringInCourses < ActiveRecord::Migration[7.1]
  def change
    change_column :courses, :duration, :string
  end
end
