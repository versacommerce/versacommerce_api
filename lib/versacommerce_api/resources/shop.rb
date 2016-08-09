# -*- encoding : utf-8 -*-
module VersacommerceAPI
  # Shop object. Use Shop.current to receive the shop.
  class Shop < Base
    include Metafieldable

    def self.collection_name
      'shop'
    end

    def self.element_path(id, prefix_options = {}, query_options = nil)
      "#{prefix(prefix_options)}#{collection_name}#{format_extension}#{query_string(query_options)}"
    end

    def self.current
      find(:one, from: '/api/shop.xml')
    end

    def to_xml(options = {})
      super(only: [:current_design, :current_sandbox_design, :current_facebook_design])
    end
  end
end
