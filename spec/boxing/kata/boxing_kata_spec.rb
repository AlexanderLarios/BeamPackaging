require 'spec_helper'
require 'csv'

RSpec.describe Boxing::Kata do
  it 'has a version number' do
    expect(Boxing::Kata::VERSION).not_to be nil
  end

  describe '.create_family' do
    let(:csv_file) { File.new('spec/fixtures/family_preferences.csv') }
    let(:table) {CSV.parse(csv_file, headers: true)}
    context 'when given table of good family data' do
      it 'creates a family that has a hash of brush color preferences and counts' do
        family = Boxing::Kata.create_family(table)
        expect(family.brushes).to eq({"blue"=>2, "green"=>2, "pink"=>2})
      end

      it 'creates a family with an effective date attribute' do
        family = Boxing::Kata.create_family(table)
        expect(family.effective_date).to eq(Date.parse('2019-10-31'))

      end
    end
  end
end

RSpec.describe Boxing::Kata::Family do
  describe '.print_brush_prefs' do
    context 'when given good data on family creation' do
      it 'prints the family\'s brush preferences' do
        family = Boxing::Kata::Family.new(brushes: {"blue"=>2, "green"=>2, "pink"=>2}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with('BRUSH PREFERENCES')
        expect(STDOUT).to receive(:puts).with('blue: 2')
        expect(STDOUT).to receive(:puts).with('green: 2')
        expect(STDOUT).to receive(:puts).with('pink: 2')
        family.print_brush_prefs
      end
    end
  end
end
