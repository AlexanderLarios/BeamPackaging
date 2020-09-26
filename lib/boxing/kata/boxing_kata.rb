require 'boxing/kata/version'
require 'boxing/kata/family'
require 'csv'

module Boxing
  module Kata

    def self.report
      puts '***** BEAM BOXER *****'
      puts "\n"

      # Check for input file stream
      unless input_file?
        puts 'Please add a file path and try again.'
        puts 'Usage: ruby ./bin/boxing-kata <spec/fixtures/family_preferences.csv'
      else
        # Import csv file to create family object
        puts 'Importing CSV...'
        puts "\n"

        # Parse CSV for family's data and construct family object
        table = CSV.parse(STDIN, headers: true)
        family = self.create_family(table)
        family.print_brush_prefs

      end
    end

    # Returns true if stream has a file and false if tied to tty
    def self.input_file?

      !STDIN.tty?
    end

    # Returns family object from CSV table
    def self.create_family(table)
      # Create hash counter where the keys are the possible colors of brushes and the values are the starting count 0
      brush_color_keys = %w(blue green pink)
      brush_color_count= brush_color_keys.map{|key| [key,0]}.to_h
      effective_date = Date.new

      table.each do |row|
        # Count how many brushes by color
        if brush_color_count.has_key?("#{row['brush_color']}")
          brush_color_count["#{row['brush_color']}"] += 1
        else
          # Handle edge case of unexpected color by adding it to hash.
          # Subject to business rules, this is a quick low maintenance way to add new colors assuming good data,
          # but less strict than the above color key collection.
          brush_color_count["#{row['brush_color']}"] = 1
        end

        # Parse contract effective date, assuming only one per table and date format 2020-10-31
        if row['contract_effective_date']
          effective_date = Date.parse(row['contract_effective_date'])
        end
      end

      family = Family.new(brushes: brush_color_count, effective_date: effective_date)
      return family
    end
  end
end
