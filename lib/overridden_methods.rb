# frozen_string_literal: true

module OverriddenMethods
  # All methods to be in Integer class
  module Life
    def alive?
      self == 1
    end

    def dead?
      !alive?
    end
  end

  # All methods to be ovverridden in String class
  module StrBool
    def true?
      self == 'true'
    end
  end
end

# Include module in Integer class
class Integer
  include OverriddenMethods::Life
end

# Include module in String class
class String
  include OverriddenMethods::StrBool
end
