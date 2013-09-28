module VersacommerceAPI
  
  class ProductImage < Base
    
    def initialize(attributes)
      super
      if self.attributes['file']
        file     = self.attributes['file']
        data     = file.read
        type, suffix = file.content_type.split("/")
        raise ArgumentError.new("file must be an image") unless ((type == "image") && %w(jpeg jpg gif png).include?(suffix))
        filename = "upload_file.#{suffix}"
        upload_image(data, filename)
        self.attributes.delete 'file'
      end
    end
    
    def pico
      generate_resized_url(original, :resize, '16x16')
    end
    
    def icon
      generate_resized_url(original, :resize, '32x32')
    end
    
    def thumb
      generate_resized_url(original, :resize, '50x50')
    end
    
    def small
      generate_resized_url(original, :resize, '100x100')
    end
    
    def medium
      generate_resized_url(original, :resize, '240x240')
    end
    
    def large
      generate_resized_url(original, :resize, '480x480')
    end
    
    def xlarge
      generate_resized_url(original, :resize, '960x960')
    end
    
    def standard
      generate_resized_url(original, :resize, '1024x1024')
    end
    
    def original
      "http://images.versacommerce.net/++/#{src.gsub("http://", "")}"
    end
    
    def upload_image(data, filename = nil)
      attributes['image_data'] = Base64.encode64(data)
      attributes['filename']   = filename unless filename.nil?
    end
    
    private
    
    def generate_resized_url(url, command, value)
      refit_url = url.gsub("\/++\/", "\/#{command}=#{value}\/++\/")
    end
    
  end

end
