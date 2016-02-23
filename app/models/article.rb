class Article < ActiveRecord::Base
	belongs_to :issue
	belongs_to :person, :foreign_key => 'author_id'
	validates :answer, :puzzle_type, :absence => true, :unless => :is_puzzle?

	def is_puzzle?
		type == "Puzzle"
	end

	searchable do
    text :text, :stored => true
    text :title, :default_boost => 1.5

    join(:year, :target => Issue, :type => :integer, :join => { :from => :id, :to => :issue_id })
    join(:month, :target => Issue, :type => :integer, :join => { :from => :id, :to => :issue_id })
    join(:name, :target => Person, :type => :integer, :join => { :from => :id, :to => :author_id })
    boolean :redacted
    string :type
    integer :issue_id
    integer :author_id
    integer :page

    string  :sort_title do
      title.downcase.gsub(/^(an?|the)/, '')
    end
  end
end
