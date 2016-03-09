class CreateWatsonConcepts < ActiveRecord::Migration
  def change
    create_table :watson_concepts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
