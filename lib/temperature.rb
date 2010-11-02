$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'temperature/numeric'
require 'temperature/string'

# Temperature works as a mixin on both the Numeric and String classes.
# The idea is to make manipulating temperatures as simple and natural
# as possible.  If units are not specified, they are assume to be in
# degrees 'F'.  Yes, I realize this is US centric, but that's where I
# live.  In the future I'd like to auto detect that base on locale.
module Temperature
    VERSION = "1.2"
end
