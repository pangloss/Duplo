class DataProcessor
  def process_with_blocks(data)
    result = data.map do |item|
      item.to_s.upcase
    end
    result.select { |x| x.length > 3 }
  end

  def transform_with_blocks(data)
    result = data.map do |item|
      item.to_s.upcase
    end
    result.select { |x| x.length > 3 }
  end

  def filter_numbers(numbers)
    evens = numbers.select { |n| n.even? }
    evens.map { |n| n * 2 }
  end

  def process_numbers(numbers)
    evens = numbers.select { |n| n.even? }
    evens.map { |n| n * 2 }
  end

  def self.class_method_one
    puts "Class method called"
    perform_calculation
  end

  def self.class_method_two
    puts "Class method called"
    perform_calculation
  end

  private

  def self.perform_calculation
    # Some complex logic here
    42 * 2
  end

  def instance_helper_one
    value = fetch_data
    value.present? ? value.upcase : "DEFAULT"
  end

  def instance_helper_two
    value = fetch_data
    value.present? ? value.upcase : "DEFAULT"
  end

  def fetch_data
    "some data"
  end
end

# Lambda and proc examples
multiply_by_two = lambda { |x| x * 2 }
square = proc { |x| x ** 2 }

# Array processing
numbers = [1, 2, 3, 4, 5]
doubled = numbers.map(&multiply_by_two)
squared = numbers.map(&square)