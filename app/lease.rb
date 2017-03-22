class Lease
  attr_reader :unit, :name, :raw

  include Comparable

  # Sample data had short and long dash
  LINE_FORMAT = %r{\#([a-zA-Z0-9]+) [-–] (.+)}
  ALPHA_UNIT_FORMAT = %r{([a-zA-Z]+)(\d*)}
  NUMERIC_UNIT_FORMAT = %r{(\d+)([a-zA-Z]*)}

  InvalidFormat = Class.new(StandardError)

  def initialize(unit, name, raw)
    @unit = unit
    @name = name
    @raw = raw

    parse_unit!
  end

  def <=>(other)
    comparator <=> other.comparator
  end

  def self.parse(string)
    matchdata = string.match(LINE_FORMAT)
    raise InvalidFormat.new(string) if matchdata.nil?

    new(matchdata[1], matchdata[2], string)
  end

  protected def comparator
    [@numeric_unit, @alpha_unit]
  end

  private

  # Matches: 50B or 5
  def parse_unit!
    begin
      parse_alpha_unit!
    rescue InvalidFormat
      parse_numeric_unit!
    end
  end

  # Matches: A100 or A
  def parse_alpha_unit!
    matchdata = unit.match(ALPHA_UNIT_FORMAT)
    raise InvalidFormat if matchdata.nil?

    @alpha_unit = matchdata[1]
    @numeric_unit = matchdata[2].to_i
  end

  def parse_numeric_unit!
    matchdata = unit.match(NUMERIC_UNIT_FORMAT)
    raise InvalidFormat if matchdata.nil?

    @numeric_unit = matchdata[1].to_i
    @alpha_unit = matchdata[2]
  end
end
