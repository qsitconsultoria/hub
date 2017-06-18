json.array!(@questions) do |question|
  json.extract! question, :id, :title, :subject_id
  json.url question_url(question, format: :json)
end
