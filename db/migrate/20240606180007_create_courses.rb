class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :technologies
      t.integer :duration
      t.text :table_of_contents
      t.decimal :price, precision: 10, scale: 2
      t.references :tutor, foreign_key: true
      t.timestamps
    end
  end
end
