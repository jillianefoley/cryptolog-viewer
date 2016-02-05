class AddAuthorIDToArticles < ActiveRecord::Migration
  def change
		add_column :article, :author_id, :integer
  end
end
