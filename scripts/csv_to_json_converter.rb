require 'byebug'
require_relative 'product_report_generator'

if ARGV.length != 1
  puts "Usage: ruby scripts/csv_to_json_converter.rb <csv_file_path>"
else
  csv_file_path = ARGV[0]
  report_generator = ProductReportGenerator.new(csv_file_path)
  json_report = report_generator.generate_report

  if json_report
    puts json_report
  else
    puts "Failed to generate the report."
  end
end