module Boxing
  module Kata
    class Box

      attr_accessor :is_starter, :count, :box_colors

      def initialize(is_starter)
        @is_starter = is_starter
        # Hash of color : count of brush/ brush head pairs for starter or just brush heads for refills
        @box_colors = Hash.new
        @count = 0

      end

      def add(color)
        # Adds a color to the box color hash
        if @box_colors.has_key?(color)
          @box_colors[color] += 1
        else
          @box_colors[color] = 1
        end
        @count +=1
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
      end
    end
  end
end