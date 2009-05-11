module Fixity
  class Record
    class << self
      attr_reader :field_order, :field_options
      
      def field(field_name, options = {})
        @field_order ||= []
        @field_order << field_name.to_sym
        @field_options ||= {}
        @field_options[field_name] = options
        
        define_method(field_name) do
          @fields[field_name].value
        end
        
        define_method("#{field_name}=") do |val|
          klass = options.dup.delete(:class)
          klass ||= Field
                    
          @fields[field_name] = klass.new(val, options)
        end
      end
    end
    
    def initialize(field_hash = nil)
      @fields = {}
      
      self.class.field_order.each do |f|
        send("#{f}=", nil)
      end
      
      update_attributes(field_hash)
    end
    
    def update_attributes(attributes)
      (attributes || []).each do |k, v|
        send("#{k}=", v)
      end
    end
        
    def to_s
      self.class.field_order.inject("") do |str, field_name|
        str << @fields[field_name].to_s
        str
      end
    end
  end
end