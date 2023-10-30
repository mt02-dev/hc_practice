require 'optparse'
require 'date'

def print_calender(month)
  year = Date.today.year

  first_day = Date.new(year,month,1)
  last_day = Date.new(year,month,-1)
  days_num = last_day.mday
  days_array = []

  if first_day.sunday?
    (1..6).each { days_array << '  '}
  end
  
  unless first_day.monday? || first_day.sunday?
    (1..first_day.wday - 1 ).each { days_array << '  ' }
  end

  (1..days_num).each do |i|
    days_array << i.to_s.rjust(2,' ')
  end 
  month_year_header = first_day.strftime("%B %Y")
  weeks_header = %w[月 火 水 木 金 土 日].join(' ')
  puts "#{month_year_header.center(20)}\n#{weeks_header}"
  
  days_array.each.with_index(1) do | day, index |
    if day == days_array[-1] 
      puts day
    elsif index % 7 == 0
      puts day
    else 
      print "#{day} "
    end
  end

end

def num_validation(num_str)
  num = num_str.to_i
  if num < 1 || 12 < num
    0
  else
    num
  end
end

def print_calender_no_opt
  print_calender(Date.today.month)
end

opt = OptionParser.new

opt.on('-m') {
  result = num_validation(ARGV[0])
  if result.nonzero?
    print_calender(result)
  else
    puts "#{ARGV[0]} is neither a month number (1..12) nor a name"
  end 
}

if ARGV.size.zero?
  print_calender_no_opt
else
  opt.parse!(ARGV)
end