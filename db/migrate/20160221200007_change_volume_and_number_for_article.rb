class ChangeVolumeAndNumberForArticle < ActiveRecord::Migration
  def change
    change_column :issues, :volume, :string
    change_column :issues, :volume_number, :string
  end
end
