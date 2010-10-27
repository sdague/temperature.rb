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
        if self =~ /^(-?)(\d+)\.(\d+)(F|C|K|R)$/
            tmp = "#{$1}#{$2}.#{$3}".to_f
            tmp.units = $4
            return tmp
        elsif self =~ /^(-?)(\d+)(F|C|K|R)$/
            tmp = "#{$1}#{$2}".to_f
            tmp.units = $3
            return tmp
        end
    end
end

