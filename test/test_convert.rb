require File.dirname(__FILE__) + '/test_helper.rb'

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

    def test_from_string_R
      numbers = [32.1, 23, -14.1, -7]
      numbers.each do |num|
        temp = "#{num}R".to_degrees
        assert_kind_of(Numeric, temp)
        assert_equal(temp, num)
        assert_equal(temp.units, "R")
        assert(temp.is_R?)
      end
    end

    def test_convert
        f = [32.0, 212.0, -40.0, 32, 212, -40]
        c = [0.0, 100.0, -40.0, 0, 100, -40]
        k = [273.15, 373.15, 233.15, 273.15, 373.15, 233.15]
        r = [491.67, 671.67, 419.67, 491.67, 671.67, 419.67]
        
        f.each_with_index do |n, i|
            temp = "#{n}F".to_degrees
            assert_in_delta(temp.to_C, c[i], 0.00001)
            assert_in_delta(temp.to_F, f[i], 0.00001)
            assert_in_delta(temp.to_K, k[i], 0.00001)
            assert_in_delta(temp.to_R, r[i], 0.00001)
        end

        c.each_with_index do |n, i|
            temp = "#{n}C".to_degrees
            assert_in_delta(temp.to_C, c[i], 0.00001)
            assert_in_delta(temp.to_F, f[i], 0.00001)
            assert_in_delta(temp.to_K, k[i], 0.00001)
            assert_in_delta(temp.to_R, r[i], 0.00001)
        end

        k.each_with_index do |n, i|
            temp = "#{n}K".to_degrees
            assert_in_delta(temp.to_C, c[i], 0.00001)
            assert_in_delta(temp.to_F, f[i], 0.00001)
            assert_in_delta(temp.to_K, k[i], 0.00001)
            assert_in_delta(temp.to_R, r[i], 0.00001)
        end
    end
    
end

