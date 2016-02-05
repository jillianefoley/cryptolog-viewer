class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :type
      t.string :puzzle_type
      t.string :text
      t.integer :redactions
      t.binary :picture
      t.boolean :redacted
      t.integer :page

      t.timestamps null: false
    end
  end
end
