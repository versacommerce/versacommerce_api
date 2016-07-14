# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Item < Base
    include Associatable

    def product
      associated_resource "product"
    end

    def order
      associated_resource "order"
    end
  end
  
end
