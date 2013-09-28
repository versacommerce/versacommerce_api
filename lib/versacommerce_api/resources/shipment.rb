module VersacommerceAPI

  class Shipment < Base
    include Associatable
    
    def order
      associated_resource "order", false
    end
  end
  
end
