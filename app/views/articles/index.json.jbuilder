json.array!(@articles) do |article|
  json.extract! article, :id, :title, :type, :puzzle_type, :text, :redactions, :picture, :redacted, :page
  json.url article_url(article, format: :json)
end
