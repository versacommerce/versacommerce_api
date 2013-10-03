# -*- encoding : utf-8 -*-
module VersacommerceAPI
  
  class Link < Base
    
    def linked
      resource.find(self.linkable_id) if self.linkable_id && resource
    end
    
    def resource
      "VersaCommerceShopApi::#{self.linkable_type}".constantize rescue nil
    end
    
  end
  
end
