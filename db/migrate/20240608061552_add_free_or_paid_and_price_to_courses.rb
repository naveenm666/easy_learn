class AddFreeOrPaidAndPriceToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :free_or_paid, :string
    add_column :courses, :price, :decimal
  end
end
