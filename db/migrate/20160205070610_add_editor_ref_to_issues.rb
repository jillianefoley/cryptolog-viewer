class AddEditorRefToIssues < ActiveRecord::Migration
  def change
		add_column :issues, :editor_id, :integer, foreign_key: true
  end
end
