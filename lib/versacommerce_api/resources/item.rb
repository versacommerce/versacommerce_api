# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Item < Base
    self.prefix = "/api/items/:item_id/"

    def product
      Product.find product_id
    end
  end
  
end
