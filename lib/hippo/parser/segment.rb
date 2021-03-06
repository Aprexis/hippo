module Hippo
  class Parser
    module Segment
      def parse(input)
        input.gsub!(/[\a\e\f\n\r\t\v]/,'')
        fields = input.split(@field_separator)

        segment_identifier = fields.shift

        fields.each_with_index do |value, index|
          field = self.class.fields[index]
          
          # IAB: I don't know if this is really needed, but I ran into an error here at one point during my
          # testing and added this check. I don't think it hurts to have it and may help in some cases.
          next unless field.present?

          # if the field is an array that means it is a
          # composite field
          if field.class == Array
            composite_fields    = value.split(@composite_separator)
            composite_sequence  = field.first.composite_sequence

            self.values[composite_sequence] = {}

            composite_fields.each_with_index do |comp_value, comp_index|
              composite_field = field[comp_index]

              self.values[composite_sequence][composite_field.sequence] = composite_field.formatted_value(comp_value)
            end
          else
            self.values[field.sequence] = field.formatted_value(value)
          end
        end

        self
      end
    end
  end
end
