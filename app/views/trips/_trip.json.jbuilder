json.extract! trip, :id, :driver_id, :passenger_id, :date, :rating, :cost, :created_at, :updated_at
json.url trip_url(trip, format: :json)
