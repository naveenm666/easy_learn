class AddValidityToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :validity, :integer, default: 0
  end
end
