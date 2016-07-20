# -*- encoding : utf-8 -*-
module VersacommerceAPI

  module Metafieldable
    def metafields
      if new_record?
        []
      else
        Metafield.find(:all, params: {metafieldable_type: self.class.collection_name.singularize.capitalize, metafieldable_id: id})
      end
    end

    def add_metafield(metafield)
      raise ArgumentError, 'Adding Metafields to an unsaved Resource is not allowed' if new_record?

      metafield.tap do |m|
        m.metafieldable_type = self.class.collection_name.singularize.capitalize
        m.metafieldable_type = id

        m.save
      end
    end
  end
end
