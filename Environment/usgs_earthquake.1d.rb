#!/usr/bin/env ruby

# Based on quake.1h.sh by Aaron Edell

# <bitbar.title>Earthquake List</bitbar.title>
# <bitbar.version>v1.0.0</bitbar.version>
# <bitbar.author>Adam Snodgrass</bitbar.version>
# <bitbar.author.github>asnodgrass</bitbar.author.github>
# <bitbar.desc>Displays a color-coded, clickable list of earthquakes sorted by magnitude in descending order as reported by the U.S. Geological Survey Earthquake Hazards Program (http://earthquake.usgs.gov/). Quakes above M5 are colored yellow, and above M6 are coded red. Default threshold is everything M4.5+ for past day, but can be configured to other frequencies and thresholds.</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>

require 'csv'
require 'open-uri'

# frequency: hour, day, week, month
freq = 'day'
# type: significant, 4.5, 2.5, 1.0, all
type = '4.5'

puts '🌎'
puts '---'
prefix = 'http://earthquake.usgs.gov/earthquakes'
url = "#{prefix}/feed/v1.0/summary/#{type}_#{freq}.csv"
csv_data = open(url)
CSV.parse(csv_data, headers: true).sort {|a,b| b['mag'] <=> a['mag'] }.each do |row|
  if row['mag'].to_f > 6
    color = 'color="red"'
  elsif row['mag'].to_f > 5
    color = 'color="yellow"'
  else
    color = ''
  end
  link = "href=\"#{prefix}/eventpage/#{row['id']}\""
  puts "M#{row['mag']} #{row['type']}  #{row['place']} | #{color} #{link}"
end
