require 'csv'
require 'json'

class ProductReportGenerator
  class InvalidCSVError < StandardError
    def message
      "Error: CSV file headers must be correct (Product ID, Product Name, Description, Price, Availability)."
    end
  end

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
  end

  def generate_report
    begin
      products = process_csv
      generate_json_report(products)
    rescue InvalidCSVError => e
      handle_error(e)
    rescue StandardError => e
      handle_error(e)
    end
  end

  private

  def process_csv
    products = []
    CSV.foreach(@csv_file_path, headers: true) do |row|
      raise InvalidCSVError unless valid_headers?(row.headers)

      product = {
        "Product ID" => row["Product ID"],
        "Product Name" => row["Product Name"],
        "Description" => row["Description"],
        "Price" => row["Price"].to_f,
        "Availability" => row["Availability"] == "true"
      }
      products << product
    end
    products
  end

  def generate_json_report(products)
    report = { "products" => products }
    json_report = report.to_json
    puts json_report
    json_report
  end

  def handle_error(e)
    puts "Error: #{e.message}"
    e.message
  end

  def valid_headers?(headers)
    headers == ["Product ID", "Product Name", "Description", "Price", "Availability"]
  end
end
