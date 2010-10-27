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
    # The scale factor between C and F
    CScale = 1.8
    # The offset between C and F
    FOffset = 32
    # The offset between K and C
    KOffset = 273.15
    # The offset between R and F
    ROffset = 459.67

    
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

    def is_R?
        return self.units == "R"
    end

    # Convert the temperature to Farenheit.  If it's already in F, it
    # returns itself.
    def to_F
        case self.units
        when "F" then return self
        when "C" then return self.c2f
        when "K" then return self.k2f
        when "R" then return self.r2f
        end
    end

    # Convert the temperature to Celcius.  If it's already in C, it
    # returns itself.
    def to_C
        case self.units
        when "F" then return self.f2c
        when "C" then return self
        when "K" then return self.k2c
        when "R" then return self.r2c
        end
    end
        
    # Convert the temperature to Kelvins.  If it's already in K, it
    # returns itself.
    def to_K
        case self.units
        when "F" then return self.f2k
        when "C" then return self.c2k
        when "K" then return self
        when "R" then return self.k2r
        end
    end

    # Convert the temperature to Rankines.
    def to_R
      case self.units
      when "F" then return self.f2r
      when "C" then return self.c2r
      when "K" then return self.k2r
      when "R" then return self
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

    def r2f
      num = self - ROffset
      num.units = "R"
      return num
    end

    def f2r
      num = self + ROffset
      num.units = "R"
      return num
    end

    def c2r
      num = self * CScale + (ROffset + FOffset)
      num.units = "R"
      return num
    end

    def k2r
      num = self * CScale
      num.units = "R"
      return num
    end

    # Compute the dewpoint for the temperature given a relative
    # humidity.  This is using the NOAA approximation for dewpoint
    # calculation -
    # http://en.wikipedia.org/wiki/Dew_point#Closer_approximation
    def dewpoint(rh)
        units = self.units
        temp = self.to_C
        e_sub_s = 6.112 * Math.exp((17.76 * temp) / (temp + 243.5))
        e = rh.to_f * e_sub_s / 100
        dew = 243.5 * Math.log(e / 6.112) / (17.67 -  Math.log(e / 6.112))
        dew.units = "C"
        final = dew.send("to_#{units}")
        return final
    end
    
    # The degree units the temperature is in.  This defaults to "F" if
    # not specified.  Valid values are "C", "F", or "K" (R is not
    # currently support... no one really uses that anyway).
    def units
        if defined?(@units) && @units
            return @units
        else
            # this should auto detect the env, but for now, I live in the US
            return "F"
        end
    end
        
    def units=(units)
        if units =~ /^(C|F|K|R)/
            @units = units
        end
        return @units
    end
    
end

