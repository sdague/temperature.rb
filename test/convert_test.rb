#!/usr/bin/ruby

require "test/unit"
require "temperature"

class ConversionTest < Test::Unit::TestCase
   
    def test_from_string_F
        numbers = [32.1, 23, -14.1, -7]
        numbers.each do |num|
            temp = "#{num}F".to_degrees
            assert_kind_of(Numeric, temp)
            assert_equal(temp, num)
            assert_equal(temp.units, "F")
            assert(temp.is_F?)
        end
    end

    def test_from_string_C
        numbers = [32.1, 23, -14.1, -7]
        numbers.each do |num|
            temp = "#{num}C".to_degrees
            assert_kind_of(Numeric, temp)
            assert_equal(temp, num)
            assert_equal(temp.units, "C")
            assert(temp.is_C?)
        end
    end

    def test_from_string_K
        numbers = [32.1, 23, -14.1, -7]
        numbers.each do |num|
            temp = "#{num}K".to_degrees
            assert_kind_of(Numeric, temp)
            assert_equal(temp, num)
            assert_equal(temp.units, "K")
            assert(temp.is_K?)
        end
    end

    def test_convert
        f = [32.0, 212.0, -40.0, 32, 212, -40]
        c = [0.0, 100.0, -40.0, 0, 100, -40]
        
        f.each_with_index do |n, i|
            temp = "#{n}F".to_degrees
            assert_equal(temp.to_C, c[i])
            assert_equal(temp.to_F, f[i])
        end

        c.each_with_index do |n, i|
            temp = "#{n}C".to_degrees
            assert_equal(temp.to_C, c[i])
            assert_equal(temp.to_F, f[i])
        end
    end
    
end

