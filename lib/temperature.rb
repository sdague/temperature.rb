class Numeric
    @units
    
    CScale = 1.8
    FOffset = 32
    KOffset = 273.15

    def units
        if @units
            return @units
        else
            # this should auto detect the env, but for now, I live in the US
            return "F"
        end
    end
        
    def units=(u)
        if u =~ /^(C|F|K)/
            @units = u
        end
        return @units
    end
    
    def is_F?
        return self.units == "F"
    end

    def is_C?
        return self.units == "C"
    end

    def is_K?
        return self.units == "K"
    end

    def to_F
        case self.units
        when "F":
                return self
        when "C":
                return self.c2f
        when "K":
                return self.k2f
        end
    end

    def to_C
        case self.units
        when "F":
                return self.f2c
        when "C":
                return self
        when "K":
                return self.k2c
        end
    end
        
    def to_K
        case self.units
        when "F":
                return self.f2k
        when "C":
                return self.c2k
        when "K":
                return self
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

