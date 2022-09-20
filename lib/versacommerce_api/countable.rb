# -*- encoding : utf-8 -*-
module VersacommerceAPI

  module Countable
    def count(options = {})
      Integer(get(:count, options)['count'])
    end
  end

end
