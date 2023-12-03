require 'rails_helper'

RSpec.describe 'Seed Data' do
  it 'saves records with proper attributes' do
    load Rails.root.join('db/seeds.rb')

    # test find_by name and row with move in and out date
    r = Resident.find_by(name: "Sally Carol")
    expect(r).to be_present
    expect(r.unit).to be_present
    expect(r.unit.floor_plan).to eq("Studio")
    expect(r.move_in_date).to eq(Date.strptime('6/1/2019', '%m/%d/%Y'))
    expect(r.move_out_date).to eq(Date.strptime('12/15/2020', '%m/%d/%Y'))

    # test find_by date and row with just move in date
    r = Resident.find_by(move_in_date: Date.strptime('3/1/2021', '%m/%d/%Y'))
    expect(r).to be_present
    expect(r.unit).to be_present
    expect(r.unit.number).to eq(2)
    expect(r.name).to eq('Sarah')
    expect(r.move_out_date).to be_nil
  end

  it 'does not create multiple units if unit has same number and saves multiple residents' do
    load Rails.root.join('db/seeds.rb')

    expect(Unit.all.count).to eq 8
    u = Unit.find_by(number: 1)
    r1 = Resident.find_by(name: "John Smith")
    r2 = Resident.find_by(name: "Sally Carol")
    expect(u.residents).to include(r1)
    expect(u.residents).to include(r2)
  end
end
