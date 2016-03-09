class CreateJoinTableArticlesWatsonConcepts < ActiveRecord::Migration
  def change
    create_join_table :articles, :watson_concepts do |t|
    end
  end
end
