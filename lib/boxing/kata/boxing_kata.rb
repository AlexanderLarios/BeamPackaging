require 'boxing/kata/version'
require 'boxing/kata/family'
require 'csv'
require 'tty-prompt'

module Boxing
  module Kata

    def self.cli
      prompt = TTY::Prompt.new

      puts '*** BEAM BOXER ***'

      # Check for input file stream
      unless ARGV.length>0
        puts 'Please add a valid file path argument.'
        puts 'Usage: ruby ./bin/boxing-kata spec/fixtures/family_preferences.csv'
      else
        # Open CSV file for family's data and construct family object'
        puts 'Importing CSV from command line argument...'
        file = CSV.open(ARGV[0], headers:  true)
        family = self.create_family(file)
        file.close

        # Print family's brush preferences
        family.print_brush_prefs

        # Main menu functionality
        loop do
          puts "\n"
          menu_response = prompt.select("*** BEAM BOXER ***", ['Family Brush Preferences','Starter Box', 'Refill Box', 'Exit'])
          case menu_response
            when 'Family Brush Preferences'
              family.print_brush_prefs
            when 'Starter Box'
              puts 'Starter Box output Placeholder'

            when 'Refill Box'
              puts 'Refill Box output Placeholder'
            when 'Exit'
             exit_cli
          end
        end
      end

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

    def self.exit_cli
      puts 'Exiting Beam Boxer...'
      exit(0)
    end
  end
end
