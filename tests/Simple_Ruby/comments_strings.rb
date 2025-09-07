class StringsAndComments
  def method_with_comments
    # This is a regular comment
    value = "string with # hash inside"
    result = value.gsub('#', '_')  # inline comment
    return result
  end

  def another_method_with_comments
    # This is a regular comment  
    value = "string with # hash inside"
    result = value.gsub('#', '_')  # inline comment
    return result
  end

  def regex_with_hash
    pattern = /test#pattern/
    text = "test#pattern matches"
    return text.match(pattern)
  end

  def another_regex_with_hash
    pattern = /test#pattern/
    text = "test#pattern matches"
    return text.match(pattern)
  end

  def interpolated_strings
    name = "World"
    greeting = "Hello #{name}!"
    puts greeting
  end

  def more_interpolated_strings
    name = "World"
    greeting = "Hello #{name}!"
    puts greeting
  end

  def symbol_methods
    hash = { :key => "value", "string_key" => 42 }
    return hash[:key]
  end

  def symbol_access
    hash = { :key => "value", "string_key" => 42 }
    return hash[:key]
  end

  # URL with # in comment should not affect string processing
  # Visit https://example.com#section for more info
  def url_example
    url = "https://example.com#section"
    return url
  end

  def another_url_example  
    url = "https://example.com#section"
    return url
  end
end