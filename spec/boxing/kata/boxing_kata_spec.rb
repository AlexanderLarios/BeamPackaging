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
        expect(family.brushes).to eq({'blue'=>2, 'green'=>2, 'pink'=>2})
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
        family = Boxing::Kata::Family.new(brushes: {'blue'=>2, 'green'=>2, 'pink'=>2}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('BRUSH PREFERENCES')
        expect(STDOUT).to receive(:puts).with('blue: 2')
        expect(STDOUT).to receive(:puts).with('green: 2')
        expect(STDOUT).to receive(:puts).with('pink: 2')
        expect(STDOUT).to receive(:puts).with("\n")
        family.print_brush_prefs
      end
    end

    context 'when given no brush preferences' do
      it 'prints prompt stating no brush preferences found' do
        family = Boxing::Kata::Family.new(brushes: {}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with('NO BRUSH PREFERENCES FOUND.')
        family.print_brush_prefs
      end
    end
  end

  describe '.generate_starter' do
    context 'when there is an even number of brush preferences' do
      it 'prints the starter boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'blue'=>2, 'green'=>2, 'pink'=>2}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('2 blue brushes')
        expect(STDOUT).to receive(:puts).with('2 blue replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: Priority')

        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('2 green brushes')
        expect(STDOUT).to receive(:puts).with('2 green replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: Priority')

        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('2 pink brushes')
        expect(STDOUT).to receive(:puts).with('2 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: Priority')
        family.generate_starter
      end
    end

    context 'when there is an odd number of brush preferences' do
      it 'prints the starter boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'blue'=>2, 'green'=>1, 'pink'=>2}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('2 blue brushes')
        expect(STDOUT).to receive(:puts).with('2 blue replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: Priority')

        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('1 green brushes')
        expect(STDOUT).to receive(:puts).with('1 green replacement heads')
        expect(STDOUT).to receive(:puts).with('1 pink brushes')
        expect(STDOUT).to receive(:puts).with('1 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: Priority')

        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('1 pink brushes')
        expect(STDOUT).to receive(:puts).with('1 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: First')
        family.generate_starter
      end
    end

    context 'when there is a single of brush preference' do
      it 'prints the starter boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'blue'=>1}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('STARTER BOX')
        expect(STDOUT).to receive(:puts).with('1 blue brushes')
        expect(STDOUT).to receive(:puts).with('1 blue replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2019-10-31')
        expect(STDOUT).to receive(:puts).with('Shipping: First')
        family.generate_starter
      end
    end

    context 'when there is an empty set of brush preferences' do
      it 'prints prompt stating starter boxes will be generated' do
        family = Boxing::Kata::Family.new(brushes: {}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with('NO STARTER BOXES GENERATED')
        family.generate_starter
      end
    end
  end

  describe '.generate_refill' do

    context 'when there is an even number of brush preferences' do
      it 'prints the refill boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'blue'=>2, 'green'=>2, 'pink'=>2}, effective_date: Date.parse('2019-10-31'))
        family.generate_starter
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('REFILL BOX')
        expect(STDOUT).to receive(:puts).with('2 blue replacement heads')
        expect(STDOUT).to receive(:puts).with('2 green replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2020-01-29, 2020-04-28, 2020-07-27, 2020-10-25')
        expect(STDOUT).to receive(:puts).with('Shipping: First')

        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('REFILL BOX')
        expect(STDOUT).to receive(:puts).with('2 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2020-01-29, 2020-04-28, 2020-07-27, 2020-10-25')
        expect(STDOUT).to receive(:puts).with('Shipping: First')

        family.generate_refill
      end
    end

    context 'when there is an odd number of brush preferences' do
      it 'prints the refill boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'blue'=>2, 'green'=>1, 'pink'=>2}, effective_date: Date.parse('2019-10-31'))
        family.generate_starter
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('REFILL BOX')
        expect(STDOUT).to receive(:puts).with('2 blue replacement heads')
        expect(STDOUT).to receive(:puts).with('1 green replacement heads')
        expect(STDOUT).to receive(:puts).with('1 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2020-01-29, 2020-04-28, 2020-07-27, 2020-10-25')
        expect(STDOUT).to receive(:puts).with('Shipping: First')

        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('REFILL BOX')
        expect(STDOUT).to receive(:puts).with('1 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2020-01-29, 2020-04-28, 2020-07-27, 2020-10-25')
        expect(STDOUT).to receive(:puts).with('Shipping: First')
        family.generate_refill
      end
    end

    context 'when there is a single brush preference' do
      it 'prints the refill boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'pink'=>1}, effective_date: Date.parse('2019-10-31'))
        family.generate_starter
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('REFILL BOX')
        expect(STDOUT).to receive(:puts).with('1 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2020-01-29, 2020-04-28, 2020-07-27, 2020-10-25')
        expect(STDOUT).to receive(:puts).with('Shipping: First')
        family.generate_refill
      end
    end

    context 'when there is a single brush preference' do
      it 'prints the refill boxes for family' do
        family = Boxing::Kata::Family.new(brushes: {'pink'=>1}, effective_date: Date.parse('2019-10-31'))
        family.generate_starter
        expect(STDOUT).to receive(:puts).with("\n")
        expect(STDOUT).to receive(:puts).with('REFILL BOX')
        expect(STDOUT).to receive(:puts).with('1 pink replacement heads')
        expect(STDOUT).to receive(:puts).with('Schedule: 2020-01-29, 2020-04-28, 2020-07-27, 2020-10-25')
        expect(STDOUT).to receive(:puts).with('Shipping: First')
        family.generate_refill
      end
    end

    context 'when there is no starter box generated' do
      it 'prints prompt to generate starter box first' do
        family = Boxing::Kata::Family.new(brushes: {'pink'=>1}, effective_date: Date.parse('2019-10-31'))
        expect(STDOUT).to receive(:puts).with('PLEASE GENERATE STARTER BOXES FIRST')
        family.generate_refill
      end
    end
  end
end
