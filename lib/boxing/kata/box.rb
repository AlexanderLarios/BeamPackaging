module Boxing
  module Kata
    class Box

      attr_accessor :is_starter, :count, :box_colors

      def initialize(is_starter:, effective_date:)
        @is_starter = is_starter
        # Hash of color : count of brush/ brush head pairs for starter or just brush heads for refills
        @box_colors = Hash.new
        @count = 0
        @effective_date = effective_date

      end

      # Adds a color to the box color hash
      def add(color)
        if @box_colors.has_key?(color)
          @box_colors[color] += 1
        else
          @box_colors[color] = 1
        end
        @count +=1
      end


      # Generate Schedule
      def print_schedule
        schedule_string = 'Schedule: '
        if @is_starter
          schedule_string = schedule_string + @effective_date.to_s
        else
          schedule_string = schedule_string + (@effective_date + 90).to_s + ", " + (@effective_date + 180).to_s + ", " + (@effective_date + 270).to_s + ", " + (@effective_date + 360).to_s
        end
        puts schedule_string
      end

      # Prints the contents of the box
      def print_contents
        if @is_starter
          puts "\n"
          puts 'STARTER BOX'
          @box_colors.each do |key, value|
            puts "#{value} #{key} brushes"
            puts "#{value} #{key} replacement heads"
          end
        else
          puts "\n"
          puts 'REFILL BOX'
          @box_colors.each do |key, value|
            puts "#{value} #{key} replacement heads"
          end
        end
        print_schedule
      end
    end
  end
end