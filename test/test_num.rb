require File.dirname(__FILE__) + '/test_helper.rb'

class NumTest < Test::Unit::TestCase
   
    def test_F
        numbers = [32.1, 23, -14.1, -7]
        numbers.each do |num|
            temp = num
            assert_kind_of(Numeric, temp)
            assert_equal(temp, num)
            assert_equal(temp.units, "F")
            assert(temp.is_F?)
        end
    end

    def test_convert
        f = [32.0, 212.0, -40.0, 32, 212, -40]
        c = [0.0, 100.0, -40.0, 0, 100, -40]
        k = [273.15, 373.15, 233.15, 273.15, 373.15, 233.15]
        r = [491.67, 671.67, 419.67, 491.67, 671.67, 419.67]
        
        f.each_with_index do |n, i|
            temp = n
            assert_in_delta(temp.to_C, c[i], 0.00001)
            assert_in_delta(temp.to_F, f[i], 0.00001)
            assert_in_delta(temp.to_K, k[i], 0.00001)
            assert_in_delta(temp.to_R, r[i], 0.00001)
        end
    end
end

