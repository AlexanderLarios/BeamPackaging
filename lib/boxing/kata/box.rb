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
        @weight

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
          schedule_string += @effective_date.to_s
        else
          schedule_string += (@effective_date + 90).to_s + ", " + (@effective_date + 180).to_s + ", " + (@effective_date + 270).to_s + ", " + (@effective_date + 360).to_s
        end
        puts schedule_string
      end

      # Generate shipping class.
      # if its at least 16oz its priority if its less than that its first class

      def print_shipping
        # Item weights in onces
        brush = 9
        brush_head = 1
        paste_kit = 7.6
        shipping_string = 'Shipping:' + ' '
        if @is_starter
          # 9oz + 1oz + 7.6oz = 17.6oz
          starter_set_weight = brush + brush_head + paste_kit
          @weight = count*starter_set_weight
        else
          # 1oz + 7.6oz = 8.6oz
          refill_set_weight = brush_head + paste_kit
          @weight = count*refill_set_weight
        end
        if @weight >= 16
          shipping_string += 'Priority'
        else
          shipping_string += 'First'
        end
        puts shipping_string
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
        puts count.to_s + ' ' + 'paste kits'
        print_schedule
        print_shipping
      end
    end
  end
end