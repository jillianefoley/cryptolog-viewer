class ChangePictureFieldToAttachment < ActiveRecord::Migration
  def up
  	remove_column :articles, :picture
    add_attachment :articles, :picture
  end

  def down
    remove_attachment :articles, :picture
    add_column :articles, :picture, :binary
  end
end
