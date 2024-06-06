class AddDetailsToTutors < ActiveRecord::Migration[7.1]
  def change
    add_column :tutors, :first_name, :string
    add_column :tutors, :last_name, :string
    add_column :tutors, :phone, :string
    add_column :tutors, :education_qualification, :string
    add_column :tutors, :profession, :string
    add_column :tutors, :work_experience, :integer
  end
end
