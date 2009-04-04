module Fixity
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