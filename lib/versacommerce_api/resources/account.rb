# -*- encoding : utf-8 -*-
module VersacommerceAPI

  # Account object. Use Account.current to receive the account details.
  class Account < Base
    def self.current
      find(:one, :from => "/api/account.xml")
    end
  end

end
