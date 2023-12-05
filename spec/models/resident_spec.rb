require 'rails_helper'

RSpec.describe Resident, type: :model do
  describe '.calculate_resident_status' do
    let(:reference_date) { Date.parse('2023-01-15') }

    context 'when resident moved in in the past and moves out in future' do
      it 'returns "current"' do
        move_in_date = Date.parse('2023-01-01')
        move_out_date = Date.parse('2023-02-01')
        status = Resident.calculate_resident_status(move_in_date, move_out_date, reference_date)
        expect(status).to eq('current')
      end
    end

    context 'when resident moves in in the future' do
      it 'returns "future"' do
        move_in_date = Date.parse('2023-02-01')
        move_out_date = nil
        status = Resident.calculate_resident_status(move_in_date, move_out_date, reference_date)
        expect(status).to eq('future')
      end
    end

    context 'when resident moved out' do
      it 'returns "past"' do
        move_in_date = Date.parse('2022-12-01')
        move_out_date = Date.parse('2023-01-01')
        status = Resident.calculate_resident_status(move_in_date, move_out_date, reference_date)
        expect(status).to eq('past')
      end
    end

    context 'when resident moved in but has no move out date' do
      it 'returns "current"' do
        move_in_date = Date.parse('2023-01-01')
        move_out_date = nil
        status = Resident.calculate_resident_status(move_in_date, move_out_date, reference_date)
        expect(status).to eq('current')
      end
    end
  end
end
