json.array!(@people) do |person|
  json.extract! person, :name, :last_name, :email, :company, :job_title, :phone, :website, :user_id
  json.url person_url(person, format: :json)
end
