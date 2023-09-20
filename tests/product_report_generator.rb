require 'csv'
require 'json'
require 'pry'
require 'test/unit'
require_relative '../scripts/product_report_generator'


class TestProductReportGenerator < Test::Unit::TestCase
  
  def test_valid_csv_file
    csv_file_path = File.join('tests/files', 'valid_product_data.csv')
    
    report_generator = ProductReportGenerator.new(csv_file_path)
    json_report = JSON.parse(report_generator.generate_report)
    assert_instance_of(Hash, json_report)
    assert_instance_of(Array, json_report['products'])
    assert_equal(2, json_report['products'].size)
  end

  def test_missing_csv_file
    csv_file_path = File.join('tests/files', 'non_existent_file.csv')
    report_generator = ProductReportGenerator.new(csv_file_path)
    json_report = report_generator.generate_report
    assert_equal("No such file or directory @ rb_sysopen - #{csv_file_path}", json_report)
  end

  def test_csv_file_with_incorrect_headers
    csv_file_path = File.join('tests/files', 'incorrect_headers.csv')
    report_generator = ProductReportGenerator.new(csv_file_path)
    json_report = report_generator.generate_report
    assert_equal("Error: CSV file headers must be correct (Product ID, Product Name, Description, Price, Availability)." ,json_report)
  end
end
