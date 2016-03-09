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
    return if article.text.blank? or article.text.downcase == "[redacted]" or article.text.include? "PDF"
    fetch = Excon.get("https://gateway.watsonplatform.net/concept-insights/api/v2/corpora/#{ACCOUNT_ID}/cryptolog2/documents/#{article.id}/related_concepts?level=2&limit=15",
       :user => USERNAME,
       :password => PASSWORD)


    response = JSON.parse(fetch.body)
    concepts = {}
    raise 'No Watson document found!' if response["concepts"].blank?
    response["concepts"].map{|x| concepts[x["concept"]["label"]] = x["score"]}

    top_concepts = concepts.select{|k, v| v > 0.9}.keys
    top_concepts.each do |concept_name|
      c = WatsonConcept.find_or_create_by(:name => concept_name)
      article.watson_concepts << c unless article.watson_concepts.include? c
    end
  end
end
