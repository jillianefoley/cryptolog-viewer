class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :month
      t.integer :year
      t.integer :volume
      t.integer :volume_number
      t.integer :pdf_number
      t.binary :pdf

      t.timestamps null: false
    end
  end
end
