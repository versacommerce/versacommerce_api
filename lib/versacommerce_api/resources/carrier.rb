# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Carrier < Base
    def topup_fee_for_country(country)
      #delivery_countries[country] rescue 0.00
      delivery_countries[country]
    end

    def price_for_country(country)
      [price, topup_fee_for_country(country)].compact.sum
    end

    def delivery_countries
      attributes[:delivery_countries].attributes
    end
  end

end
