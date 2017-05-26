require "xml"
require "benchmark"

require "redis"
require "myhtml"
require "crystagiri"

redis = Redis.new

key = "cowapi:Dad-12262/us/pc"

if data = redis.get(key)
  Benchmark.ips do |x|
    x.report("xml lib") {
      doc = XML.parse_html(data.not_nil!)
    }
    x.report("crystagiri") {
      doc = Crystagiri::HTML.new(data.not_nil!)
    }
    x.report("myhtml") {
      doc = Myhtml::Parser.new(data.not_nil!)
    }
  end
else
  puts "no redis value for #{key}"
end
