require 'csv'
require 'pry'

CSV.foreach(Rails.root.join('db/seeds/units-and-residents.csv'), headers: true) do |row|
  unit = Unit.find_or_create_by!(
    number: row['unit'],
    floor_plan: row['floor_plan']
  )

  if row['resident'].present?
    r = Resident.new(
      unit: unit,
      name: row['resident']
    )
    r.move_in_date = Date.strptime(row['move_in'], '%m/%d/%Y') if row['move_in'].present?
    r.move_out_date = Date.strptime(row['move_out'], '%m/%d/%Y') if row['move_out'].present?
    r.save!
  end
end
