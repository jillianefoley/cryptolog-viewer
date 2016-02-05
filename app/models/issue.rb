class Issue < ActiveRecord::Base
		belongs_to :person, :foreign_key => 'editor_id'
end
