# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Customer < Base
    include Associatable
    include Metafieldable

    def billing_address
      associated_resource "billing_address", false
    end

    def shipment_address
      associated_resource "shipment_address", false
    end
  end

end
