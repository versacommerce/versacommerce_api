# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Item < Base
    def product
      Product.find product_id
    end
  end
  
end
