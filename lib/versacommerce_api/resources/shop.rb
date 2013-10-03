# -*- encoding : utf-8 -*-
module VersacommerceAPI

  # Shop object. Use Shop.current to receive the shop.
  class Shop < Base
    def self.current
      find(:one, :from => "/api/shop.xml")
    end
  end

end
