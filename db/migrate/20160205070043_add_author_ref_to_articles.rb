class AddAuthorRefToArticles < ActiveRecord::Migration
  def change
		add_column :articles, :author_id, :integer, foreign_key: true
  end
end
