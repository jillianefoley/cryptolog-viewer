class ChangePdfColumnToPaperclip < ActiveRecord::Migration
  def up
  	remove_column :issues, :pdf
    add_attachment :issues, :pdf
  end

  def down
    remove_attachment :issues, :pdf
    add_column :issues, :pdf, :binary
  end
end
