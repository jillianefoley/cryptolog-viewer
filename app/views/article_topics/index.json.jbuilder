json.array!(@article_topics) do |article_topic|
  json.extract! article_topic, :id, :name, :top_words
  json.url article_topic_url(article_topic, format: :json)
end
