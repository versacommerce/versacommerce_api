# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Shipment < Base
    include Associatable
    
    def order
      associated_resource "order", false
    end
  end
  
end
