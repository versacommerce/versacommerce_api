# -*- encoding : utf-8 -*-
require 'uri'
require 'net/http'
module VersacommerceAPI
  
  class Session
    cattr_accessor :api_key
    cattr_accessor :secret
    cattr_accessor :protocol
    cattr_accessor :domain
    self.protocol = 'https'
    
    attr_accessor :url, :token, :name
    
    
    def initialize(url, token = nil, params = nil)
      self.url, self.token = url, token
      
      if params && params[:signature]
        unless self.class.validate_signature(params) && params[:timestamp].to_i > 24.hours.ago.utc.to_i
          raise "Invalid Signature: Possible malicious login"
        end
      end
      
      self.class.prepare_url(self.url)
    end
    
    
    def self.setup(params)
      params.each { |k,value| send("#{k}=", value) }
    end
    
    
    def self.request_token(domain)
      return nil if domain.blank? || api_key.blank?
      begin
        uri = URI("https://#{domain}/api/auth.xml?api_key=#{api_key}")
        res = Net::HTTP.get_response(uri)
        Hash.from_xml(res.body)["token"] if res&.body
      rescue
        nil
      end
    end
    
    def self.get_password
      return nil if domain.blank? || api_key.blank? || secret.blank?
      
      token = request_token(domain)
      return if token.blank?
      
      Digest::MD5.hexdigest(secret + token)
    end
    
    
    
    def shop
      Shop.current
    end
    
    
    def create_permission_url
      return nil if url.blank? || api_key.blank?
      "#{protocol}://#{url}/api/auth?api_key=#{api_key}"
    end
    
    
    # Used by ActiveResource::Base to make all non-authentication API calls
    def site
      "#{protocol}://#{api_key}:#{computed_password}@#{url}/api/"
    end
    
    
    def valid?
      url.present? && token.present?
    end
    
    private
    
    # The secret is computed by taking the shared_secret which we got when
    # registring this third party application and concating the request_to it,
    # and then calculating a MD5 hexdigest.
    
    # secret = shared_key
    # token  was provided by registration
    def computed_password
      Digest::MD5.hexdigest(secret + token.to_s)
    end
    
    def self.prepare_url(url)
      return nil if url.blank?
      url.gsub!(/https?:\/\//, '') # remove http:// or https://
      url.concat(".versacommerce.de") unless url.include?('.')  # extend url to versacommerce.de if no host is given
    end
    
    def self.validate_signature(params)
      return false unless signature = params[:signature]
      
      sorted_params = params.except(:signature, :action, :controller).collect{|k,v|"#{k}=#{v}"}.sort.join
      Digest::MD5.hexdigest(secret + sorted_params) == signature
    end
  end
  
end
