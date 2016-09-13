#!/usr/bin/env ruby

require "httparty"
require "nokogiri"

class RubyTVDB

  @@version = '0.0.1'
  @@mirror = 'http://thetvdb.com'

  def initialize(api_key, language = 'en')
    @api_key = api_key
    @language = language
  end

  def search(query)
    request = HTTParty.get("#{@@mirror}/api/GetSeries.php?seriesname=#{query}")

    results = Nokogiri::XML(request.body).xpath('//Series').map do |node|
      {
        id: node.search('seriesid').text,
        name: node.search('SeriesName').text
      }
    end
    puts results
  end
end

test = RubyTVDB.new('D229EEECFE78BA5F')

puts "RubyTVDB"
test.search("House")
