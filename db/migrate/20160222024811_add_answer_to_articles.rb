class AddAnswerToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :answer, :text
  end
end
