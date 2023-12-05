class Resident < ApplicationRecord
  belongs_to :unit

  def self.calculate_resident_status(move_in_date, move_out_date, for_date)
    return 'future' if move_in_date > for_date
    return 'current' if move_in_date <= for_date && (move_out_date.nil? || move_out_date > for_date)
    'past'
  end
end
