# -*- encoding : utf-8 -*-
module VersacommerceAPI

  module Associatable
    def associated_resource association, pluralize=true
      association = association.pluralize if pluralize
    
      if self.new? or attributes[association]
        attributes[association]
      else
        # dont create traffic if we know already there are no associated records...
        return [] if self.respond_to?("#{association}_count") && self.send("#{association}_count") == 0 && pluralize
        klass = "VersacommerceAPI::#{association.classify}".constantize
        # ensure we don´t have the association already included
        attributes[association] ||= begin
          resource_name = self.class.name.split("::").last.tableize
          klass.prefix = "/api/#{resource_name}/#{self.id}/"
          pluralize ? klass.find(:all) : klass.find(:one)
        end
        klass.root!
        attributes[association]
      end
    end
  end

end