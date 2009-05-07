require File.dirname(__FILE__) + '/../test_helper'

class FieldTest < Test::Unit::TestCase
  context 'formatting a field' do
    should 'use exactly the field width' do
      f = Fixity::Field.new("abc", :length => 3)
      
      assert_equal 'abc', f.to_s
    end
    
    should 'use no more than the field width' do
      f = Fixity::Field.new("abcd", :length => 3)
      
      assert_equal 'abc', f.to_s
    end
    
    should 'fill the entire field width' do
      f = Fixity::Field.new("ab", :length => 3)
      
      assert_equal ' ab', f.to_s
    end
  end
end
