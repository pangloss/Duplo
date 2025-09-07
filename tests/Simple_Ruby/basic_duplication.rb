#!/usr/bin/env ruby

class Calculator
  def calculate_total(items)
    sum = 0
    items.each do |item|
      sum += item.price
    end
    sum
  end

  def compute_sum(items)
    sum = 0
    items.each do |item|
      sum += item.price
    end
    sum
  end

  def process_data(data)
    result = []
    data.each do |element|
      processed = element.strip.downcase
      result << processed
    end
    result
  end

  def clean_data(data)
    result = []
    data.each do |element|
      processed = element.strip.downcase
      result << processed
    end
    result
  end
end

# This is a comment that should be ignored
def standalone_function
  puts "Hello World"
  return 42
end

def another_function
  puts "Hello World"
  return 42
end