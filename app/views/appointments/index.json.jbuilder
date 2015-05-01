json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :title, :start, :end, :notes, :client_id, :alerts, :url, :calendar_id
  json.url appointment_url(appointment, format: :json)
end
