# This file is for helper functions pertaining to
# different parts of COWAPI. 

module Cowapi
  # Change spaces and - to _ for JSON
  def self.make_json_friendly(input : String) : String
    input.gsub(/\W+/, "_").downcase
  end

  # Reduce repetitive .xpath("...").as(XML::NodeSet)
  # in parser.cr
  def self.xpath_ns(element, path)
    element.xpath(path).as(XML::NodeSet)
  end

  def self.jsonify_error(message)
    {error: message}.to_json
  end

  def self.split_hero_params(input)
    heroNames = input.split("+")
    output = {} of String => String

    heroNames.each do |heroName|
      output[heroName] = HERO_DIV_IDS[heroName] if HERO_DIV_IDS[heroName]?
    end

    return heroNames.size, output
  end


  # convert hh:mm:ss -> seconds
  def self.parse_time(input : String) : Int32
    input.split(':').map { |a| a.to_i }.reduce(0) { |a, b| a * 60 + b }
  end

  def self.resolve_value(value) : Int32 | String | Float32
    if value == "--"
      0
    elsif val = value.to_i32?
      val
    elsif val = value.to_f32?
      val
    elsif value.includes?(':')
      parse_time(value)
    elsif value.includes?("%")
      value[0...-1].to_f32 * 0.01
    elsif value.includes?(',')
      val = value.gsub(",", "")
      val.to_i32? || val.to_f32
    elsif match = value.match(/(?<sec>\d+)\.(\d+) seconds/)
      match["sec"].to_i32
    elsif match = value.match(/(?<min>\d+) minute|minutes/)
      match["min"].to_i32 * 60
    elsif match = value.match(/(?<hrs>\d+) hour|hours/)
      match["hrs"].to_i32 * 60 * 60
    else
      LOG.warn("Unable to decipher value! Message @azah about this.")
      LOG.warn(value)
      value
    end
  end
end
