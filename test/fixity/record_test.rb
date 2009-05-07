require File.dirname(__FILE__) + '/../test_helper'

class RecordTest < Test::Unit::TestCase
  context 'single field' do
    setup do
      @class = Class.new(Fixity::Record) do
        field :foo, :length => 3
      end
    end

    should "assign record" do
      foo_record = @class.new
      foo_record.foo = "bar"

      assert_equal "bar", foo_record.to_s
    end
    
    should 'truncate if the field is too short' do
      foo_record = @class.new
      foo_record.foo = "quux"

      assert_equal "quu", foo_record.to_s
    end
    
    should 'right align with spaces if the field is too long' do
      foo_record = @class.new
      foo_record.foo = 'hi'
      
      assert_equal ' hi', foo_record.to_s
    end
  end
  
  context 'multiple fields' do
    setup do
      @class = Class.new(Fixity::Record) do
        field :foo, :length => 3
        field :bar, :length => 2
        field :baz, :length => 5
      end
    end
    
    should 'work for 3 fields of the proper length' do
      record = @class.new
      record.foo = 'foo'
      record.bar = 'hi'
      record.baz = 'hello'
      
      assert_equal 'foohihello', record.to_s
    end
    
    should 'work for 3 short fields' do
      record = @class.new
      record.foo = 'fo'
      record.bar = 'h'
      record.baz = 'hell'
      
      assert_equal ' fo h hell', record.to_s
    end
    
    should 'work for 3 long fields' do
      record = @class.new
      record.foo = 'foobar'
      record.bar = 'hithere'
      record.baz = 'hellosir'
      
      assert_equal 'foohihello', record.to_s
    end
  end
  
  context 'custom fields' do
    setup do
      field_class = Class.new(Fixity::Field) do
        def to_s; "bar"; end
      end
      
      @class = Class.new(Fixity::Record) do
        field :foo, :class => field_class
      end
    end
    
    should 'use the custom class instead of the default' do
      foo_record = @class.new
      foo_record.foo = "foo"

      assert_equal "bar", foo_record.to_s
    end
  end
end
