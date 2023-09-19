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
      products = []

      CSV.foreach(@csv_file_path, headers: true) do |row|
        unless valid_headers?(row.headers)
          raise InvalidCSVError
        end

        product = {
          "Product ID" => row["Product ID"],
          "Product Name" => row["Product Name"],
          "Description" => row["Description"],
          "Price" => row["Price"].to_f,
          "Availability" => row["Availability"] == "true"
        }
        products << product
      end

      report = { "products" => products }
      return report.to_json

    rescue InvalidCSVError => e
      return e.message

    rescue StandardError => e
      puts "Error: #{e.message}"
      return nil
    end
  end

  private

  def valid_headers?(headers)
    expected_headers = ["Product ID", "Product Name", "Description", "Price", "Availability"]
    headers == expected_headers
  end
end
