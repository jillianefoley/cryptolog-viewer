class AddDepartmentRefToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :department, index: true, foreign_key: true
  end
end
