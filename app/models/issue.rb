class Issue < ActiveRecord::Base
		belongs_to :person, :foreign_key => 'editor_id'
		has_many :articles

		def name
			"Vol. #{volume} Num. #{volume_number}, #{month} #{year}"
		end

		def date
			"#{month} #{year}"
		end
end
