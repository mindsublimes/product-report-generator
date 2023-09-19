require 'byebug'
require 'minitest/autorun'
require_relative '../scripts/csv_to_json_script'

class CsvToJsonTest < Minitest::Test
  
  def test_generate_product_report

    csv_data = <<~CSV
      Product ID,Product Name,Description,Price,Availability
      1,Product 1,Description 1,10.99,true
      2,Product 2,Description 2,19.95,false
    CSV

    Tempfile.create(['test', '.csv']) do |tempfile|
      tempfile.write(csv_data)
      tempfile.rewind
      debugger
      json_report = generate_product_report(tempfile.path)

      expected_report = [
        {
          "Product ID": "1",
          "Product Name": "Product 1",
          "Description": "Description 1",
          "Price": 10.99,
          "Availability": true
        },
        {
          "Product ID": "2",
          "Product Name": "Product 2",
          "Description": "Description 2",
          "Price": 19.95,
          "Availability": false
        }
      ].to_json

      debugger

      assert_equal expected_report, json_report
    end
  end
end
