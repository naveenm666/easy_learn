class RemovePriceFromCourses < ActiveRecord::Migration[7.1]
  def change
    remove_column :courses, :price, :decimal
  end
end
