module Boxing
  module Kata
    class Family
      # Represents a beam family

      attr_reader(:brushes, :effective_date)

      def initialize(brushes:, effective_date:)
        @brushes = brushes
        @effective_date = effective_date
      end

      # Print family's brush preferences
      def print_brush_prefs

        if !self.brushes.empty?
          puts "\nBRUSH PREFERENCES"
          self.brushes.each do |key, value|
            puts "#{key}: #{value}"
          end
          puts "\n"
        else
          puts 'Problem importing family brush preferences from CSV'
        end
      end

    end
  end
end