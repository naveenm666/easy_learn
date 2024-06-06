class AddNameToTutors < ActiveRecord::Migration[7.1]
  def change
    add_column :tutors, :name, :string
  end
end
