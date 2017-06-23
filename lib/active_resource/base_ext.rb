module ActiveResource
  class Base
    def self.build(attributes = {})
      attrs = format.decode(connection.get(new_element_path, headers).body).merge(attributes)
      new(attrs)
    end
  end
end
