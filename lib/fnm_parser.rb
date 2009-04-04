module ParseFixed
  class Record
    class << self
      attr_reader :field_order, :field_options
      
      def field(field_name, options = {})
        @field_order ||= []
        @field_order << field_name.to_sym
        
        define_method(field_name) do
          @fields[field_name].value
        end
        
        define_method("#{field_name}=") do |val|
          @fields[field_name] = Field.new(val, options)
        end
      end
    end
    
    def initialize
      @fields = {}
    end
        
    def to_s
      self.class.field_order.inject("") do |str, field_name|
        str << @fields[field_name].to_s
        str
      end
    end
  end
  
  class Field
    attr_accessor :length, :value
    
    def initialize(value, options = {})
      self.length = options[:length]
      self.value = value
    end
    
    def to_s
      sprintf("%-#{length}.#{length}s", value)
    end
  end
end