module Boxing
  module Kata
    class Family
      # Represents a beam family in the context of generating boxes for shipment
      attr_reader :brushes, :effective_date, :starter_box_created

      def initialize(brushes:, effective_date:)
        @brushes = brushes
        @effective_date = effective_date
        @starter_box_created = false
      end

      # Print family's brush preferences
      def print_brush_prefs
        if !self.brushes.empty?
          puts"\n"
          puts 'BRUSH PREFERENCES'
          self.brushes.each do |key, value|
            puts "#{key}: #{value}"
          end
          puts "\n"
        else
          puts 'NO BRUSH PREFERENCES FOUND.'
        end
      end

      # Generate Starter Box for Family
      def generate_starter
        if @brushes.empty?
          return puts "NO STARTER BOXES GENERATED"
        end
        self.print_boxes(is_starter: true)
        @starter_box_created = true
      end

      # Generate Refill Box for Family
      def generate_refill
        if @starter_box_created
          self.print_boxes(is_starter: false)
        else
          puts "PLEASE GENERATE STARTER BOXES FIRST"
        end
      end

      # Prints box contents based on family preferences
      def print_boxes(is_starter:)
        if is_starter
          capacity = 2 # Brush / brush head pairs
        else
          capacity = 4 # Brush heads
        end
        box = Box.new(is_starter)
        @brushes.each do |key, value|
          color_count = "#{value}".to_i
          while color_count > 0 do
            box.add("#{key}")
            # Check if box is full
            if box.count == capacity
              box.print_contents
              box = Box.new(is_starter)
            end
            color_count -=1
          end
        end
        # Finish partially filled box
        if box.count > 0 and box.count < capacity
          box.print_contents
        end
      end
    end
  end
end