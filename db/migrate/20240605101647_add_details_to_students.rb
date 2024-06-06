class AddDetailsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :phone_number, :integer
    add_column :students, :education_qualification, :string
  end
end
