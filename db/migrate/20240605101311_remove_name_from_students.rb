class RemoveNameFromStudents < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :name, :string
  end
end
