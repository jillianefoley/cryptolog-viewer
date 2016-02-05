json.array!(@issues) do |issue|
  json.extract! issue, :id, :month, :year, :volume, :volume_number, :pdf_number, :pdf
  json.url issue_url(issue, format: :json)
end
