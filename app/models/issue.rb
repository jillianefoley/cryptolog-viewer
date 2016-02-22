class Issue < ActiveRecord::Base
		belongs_to :person, :foreign_key => 'editor_id'
		has_many :articles
		has_attached_file :pdf
		validates_attachment :pdf, content_type: { content_type: "application/pdf" }

		def name
			"Vol. #{volume} No. #{volume_number}, #{month} #{year}"
		end

		def date
			"#{month} #{year}"
		end
end
