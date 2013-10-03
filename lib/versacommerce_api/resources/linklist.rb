# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Linklist < Base
    include Associatable
    
    def links
      associated_resource "link"
    end
  end
  
end
