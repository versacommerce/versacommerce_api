module VersacommerceAPI

  class Base < ActiveResource::Base
    extend Countable
    self.format = :xml
    self.headers['User-Agent'] = ["VersacommerceAPI/#{VersacommerceAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')
    
    def self.all
      self.find(:all)
    end
    
    def self.root!
      self.prefix = "/"
    end
    
    class << self
      def headers
        if defined?(@headers)
          @headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          @headers ||= {}
        end
      end

      def activate_session(session)
        self.site = session.site
        self.headers.merge!('X-Versacommerce-API-Token' => session.token)
      end

      def clear_session
        self.site = nil
        self.headers.delete('X-Versacommerce-API-Token')
      end
    end
    
  end

end
