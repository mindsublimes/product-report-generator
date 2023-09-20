# Product Report Generator

The **Product Report Generator** is a Ruby script that reads a CSV file containing product data and generates a JSON report. This script is designed to help you convert product data stored in a CSV file into a structured JSON format.

## Usage

### Cloning the Repository

To use the Product Report Generator, you can clone this repository to your local machine using the following steps:

1. Open your terminal or command prompt.

2. Navigate to the directory where you want to clone the repository.

3. Run the following command to clone the repository:
   git clone https://github.com/mindsublimes/product-report-generator.git



### Installing Dependencies

After cloning the repository, you'll need to install the required dependencies. Make sure you have Ruby installed on your system. Then, follow these steps:

Navigate to the project directory:

cd product-report-generator

Run the following command to install the necessary gems (CSV and JSON):

bundle install

### To generate a JSON report from a CSV file, follow these steps:

1. To generate a JSON report from a CSV file run the following command.

ruby -r "./scripts/product_report_generator.rb" -e "ProductReportGenerator.new('./tests/files/valid_product_data.csv').generate_report"

2.For invalid data run the following command.

ruby -r "./scripts/product_report_generator.rb" -e "ProductReportGenerator.new('./tests/files/incorrect_headers.csv').generate_report"

### Testing

To ensure correctness, test cases are included. Run them with:

ruby -Ilib:test tests/product_report_generator.rb

### Design Choices

The script has been designed to read a CSV file with specific column headers ("Product ID," "Product Name," "Description," "Price," and "Availability") and convert the data into a JSON report. It uses error handling to gracefully handle potential issues, such as missing CSV files or incorrect file formats.