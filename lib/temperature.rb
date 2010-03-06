module Temperature
    VERSION = "1.1.0"
end

# Temperature works as a mixin on both the Numeric and String classes.
# The idea is to make manipulating temperatures as simple and natural
# as possible.  If units are not specified, they are assume to be in
# degrees 'F'.  Yes, I realize this is US centric, but that's where I
# live.  In the future I'd like to auto detect that base on locale.
#
# Example use:
#
#   freezing_in_C = 32.to_C
#
#   num = 0
#   num.units = "C"
#   freezing_in_F = num.to_F
class Numeric
    @units = "F"

    # The scale factor between C and F
    CScale = 1.8
    # The offset between C and F
    FOffset = 32
    # The offset between K and C
    KOffset = 273.15

    # The degree units the temperature is in.  This defaults to "F" if
    # not specified.  Valid values are "C", "F", or "K" (R is not
    # currently support... no one really uses that anyway).
    def units
        if @units
            return @units
        else
            # this should auto detect the env, but for now, I live in the US
            return "F"
        end
    end
        
    def units=(units)
        if units =~ /^(C|F|K)/
            @units = units
        end
        return @units
    end
    
    # Is this a Farenheit temperature, returns a boolean
    def is_F?
        return self.units == "F"
    end

    # Is this a Celcius temperature, returns a boolean
    def is_C?
        return self.units == "C"
    end

    # Is this a Kelvin temperature, returns a boolean
    def is_K?
        return self.units == "K"
    end

    # Convert the temperature to Farenheit.  If it's already in F, it
    # returns itself.
    def to_F
        case self.units
        when "F" then return self
        when "C" then return self.c2f
        when "K" then return self.k2f
        end
    end

    # Convert the temperature to Celcius.  If it's already in C, it
    # returns itself.
    def to_C
        case self.units
        when "F" then return self.f2c
        when "C" then return self
        when "K" then return self.k2c
        end
    end
        
    # Convert the temperature to Kelvins.  If it's already in K, it
    # returns itself.
    def to_K
        case self.units
        when "F" then return self.f2k
        when "C" then return self.c2k
        when "K" then return self
        end
    end
        
    def c2f
        num = self * CScale + FOffset
        num.units = "F"
        return num
    end

    def f2c
        num = (self - FOffset) / CScale
        num.units = "C"
        return num
    end

    def c2k
        num = self + KOffset
        num.units = "K"
        return num
    end
    
    def k2c
        num = self - KOffset
        num.units = "C"
        return num
    end
    
    def f2k
        self.f2c.c2k
    end

    def k2f
        self.k2c.c2f
    end

    # Compute the dewpoint for the temperature given a relative
    # humidity.  This is using the NOAA approximation for dewpoint
    # calculation -
    # http://en.wikipedia.org/wiki/Dew_point#Closer_approximation
    def dewpoint(rh)
        units = self.units
        temp = self.to_C
        e_sub_s = 6.112 * Math.exp((17.76 * temp) / (temp + 243.5))
        e = rh * e_sub_s / 100
        dew = 243.5 * Math.log(e / 6.112) / (17.67 -  Math.log(e / 6.112))
        dew.units = "C"
        final = dew.send("to_#{units}")
        return final
    end

        
end

class String
    
    # Parse a string that looks like a temperature into a temperature
    # of the right units.  It handles strings of the format
    #   
    #   35.1C
    #   72K
    #   -40F
    #
    # Decimals are support, as are negative numbers.  The units must
    # be C, K, or F, and not have a space between the numer and the
    # units
    def to_degrees
        if self =~ /^(-?)(\d+)\.(\d+)(F|C|K)$/
            tmp = "#{$1}#{$2}.#{$3}".to_f
            tmp.units = $4
            return tmp
        elsif self =~ /^(-?)(\d+)(F|C|K)$/
            tmp = "#{$1}#{$2}".to_f
            tmp.units = $3
            return tmp
        end
    end
    
    
end

