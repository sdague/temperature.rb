require File.dirname(__FILE__) + '/test_helper.rb'

class DewpointTest < Test::Unit::TestCase
    
    # the edgecase is funny, 0.5 degrees is about as close as you get
    def test_dewpoint
        (1..100).each do |temp|
            assert_in_delta(temp, temp.dewpoint(100), 0.5)
        end
    end

    def test_dewpoint_s
        (1..100).each do |temp|
            assert_in_delta(temp, temp.dewpoint("100"), 0.5)
        end
    end

end

