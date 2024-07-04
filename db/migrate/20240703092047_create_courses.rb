class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.references :tutor, null: false, foreign_key: true
      t.string :title
      t.string :technologies
      t.string :duration
      t.text :table_of_contents
      t.boolean :free
      t.decimal :price

      t.timestamps
    end
  end
end
