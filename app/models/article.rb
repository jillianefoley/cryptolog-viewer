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
  end

  def populate_watson_concepts
    username = "b22ed3d7-9fae-4c16-9b6a-3a8114bd5cd8"
    password = "5COW4wYEtsOi"
    account_id = "ly3tiesmer1ten"

    create = Excon.put("https://gateway.watsonplatform.net/concept-insights/api/v2/corpora/#{account_id}/cryptolog2/documents/#{id}",
       :user => username,
       :password => password,
       :body => {
       "label" => title,
       "parts" => [
          {
             "data" => text,
             "name" => "Text part",
             "content-type" => "text/plain"
          }
       ],
       "user_fields" => {
         "rails_id" => id
       }
    }.to_json,
     )

    # get = Excon.get("https://gateway.watsonplatform.net/concept-insights/api/v2/corpora/#{account_id}/cryptolog2/documents/#{id}/annotations",
    #    :user => username,
    #    :password => password)


    response = JSON.parse(create.body)
    concepts = {}
    response["annotations"][0].map{|x| concepts[x["concept"]["label"]] = x["score"]}

    top_5_concepts = concepts.sort_by{|k, v| v}.reverse.map{|x| x[0]}[0..4]
    puts top_5_concepts
    # top_5_concepts.each do |concept_name|
    #   c = WatsonConcept.find_or_create_by(:name => concept_name)
    #   watson_concepts << c unless watson_concepts.include? c
    # end
  end
end
