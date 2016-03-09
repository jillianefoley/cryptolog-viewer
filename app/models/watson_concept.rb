class WatsonConcept < ActiveRecord::Base
  has_and_belongs_to_many :articles

  USERNAME = "b22ed3d7-9fae-4c16-9b6a-3a8114bd5cd8"
  PASSWORD = "5COW4wYEtsOi"
  ACCOUNT_ID = "ly3tiesmer1ten"

  def self.create_watson_concepts(article)
    return if article.text.blank? or article.text.downcase == "[redacted]"
    create = Excon.put("https://gateway.watsonplatform.net/concept-insights/api/v2/corpora/#{ACCOUNT_ID}/cryptolog2/documents/#{article.id}",
       :user => USERNAME,
       :password => PASSWORD,
       :body => {
       "label" => article.title,
       "parts" => [
          {
             "data" => article.text,
             "name" => "Text part",
             "content-type" => "text/plain"
          }
       ],
       "user_fields" => {
         "rails_id" => article.id
       }
      }.to_json,
     )
  end

  def self.populate_watson_concepts(article)
    return if article.text.blank? or article.text.downcase == "[redacted]"
    fetch = Excon.get("https://gateway.watsonplatform.net/concept-insights/api/v2/corpora/#{ACCOUNT_ID}/cryptolog2/documents/#{article.id}/annotations",
       :user => USERNAME,
       :password => PASSWORD)


    response = JSON.parse(fetch.body)
    concepts = {}
    raise 'No Watson document found!' if response["annotations"].blank?
    response["annotations"][0].map{|x| concepts[x["concept"]["label"]] = x["score"]}

    top_5_concepts = concepts.sort_by{|k, v| v}.reverse.map{|x| x[0]}[0..4]
    top_5_concepts.each do |concept_name|
      c = WatsonConcept.find_or_create_by(:name => concept_name)
      article.watson_concepts << c unless article.watson_concepts.include? c
    end
  end
end
