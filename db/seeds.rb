require "csv"

CSV.foreach('db/ct.csv', headers: true) do |row|
  Category.create(
    id: row['id'],
    name: row['name'],
    parent_id: row['parent_id']
  )
end