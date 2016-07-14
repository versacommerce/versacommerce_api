# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Item < Base
    def self.root!
      self.prefix = "/api/"
    end
  end
  
end
