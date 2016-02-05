class AddIssueRefToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :issue, index: true, foreign_key: true
  end
end
