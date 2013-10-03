# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class BillingAddres < Base
    def fullname
      [firstname, lastname].delete_if(&:blank?).compact * " "
    end
  end
  
end
