class ChangePhoneNumberToStringInStudents < ActiveRecord::Migration[7.1]
  def up
    change_column :students, :phone_number, :string
  end

  def down
    change_column :students, :phone_number, :integer
  end
end
