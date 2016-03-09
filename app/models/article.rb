class Article < ActiveRecord::Base
	belongs_to :issue
	belongs_to :person, :foreign_key => 'author_id'
	validates :answer, :puzzle_type, :absence => true, :unless => :is_puzzle?
    has_attached_file :picture
    validates_attachment :picture, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
    has_and_belongs_to_many :watson_concepts

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

    integer :concept_ids, :multiple => true do
        watson_concepts.map(&:id)
    end
  end

  def articles_related_by_concepts
    query = Article.connection.execute("select article_id, count(watson_concept_id) from articles_watson_concepts awc
      where watson_concept_id in (#{watson_concepts.map(&:id).join(",")})
      and article_id <> #{id}
      group by article_id
      having count(watson_concept_id) >= 3
      order by 2 desc")
    query.map{|q| q["article_id"]} unless query.blank?
  end
end
