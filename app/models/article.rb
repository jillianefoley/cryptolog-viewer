class Article < ActiveRecord::Base
	belongs_to :issue
	belongs_to :person, :foreign_key => 'author_id'
end
