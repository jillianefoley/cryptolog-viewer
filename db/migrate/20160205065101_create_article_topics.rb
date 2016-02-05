class CreateArticleTopics < ActiveRecord::Migration
  def change
    create_table :article_topics do |t|
      t.string :name
      t.string :top_words

      t.timestamps null: false
    end
  end
end
