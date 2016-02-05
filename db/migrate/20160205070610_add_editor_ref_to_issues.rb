class AddEditorRefToIssues < ActiveRecord::Migration
  def change
		add_column :issue, :editor_id, :integer
  end
end
