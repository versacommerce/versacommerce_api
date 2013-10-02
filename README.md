# VersacommerceAPI

The VersaCommerce API gem allows Ruby developers to programmatically access the admin section of VersaCommerce shops. The API is implemented as JSON or XML over HTTP using all four verbs (GET/POST/PUT/DELETE). Each resource, like Order, Product, or Collection, has its own URL and is manipulated in isolation.

## Installation

Add this line to your application's Gemfile:

    gem 'versacommerce_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install versacommerce_api

## Introduction

Every app needs to:

1. Registered with VersaCommerce. You will receive an APP_KEY and a shared secret.
2. Registered with a Shop. This will provide a token.

You communicate with your shop using your APP_KEY and a generated password. The password is an MD5-Hash of your token and shared secret.


For detailed information see: [Authentication](https://github.com/versacommerce/vc-api/blob/master/sections/authentication.md)


## Registering your app with a shop.

    $ open http://YOUR-VERSACOMMERCE-DOMAIN.versacommerce.de/api/auth?api_key=API_KEY

## Interactive console

    You need you API-KEY and generated password. (http://YOUR-VERSACOMMERCE-DOMAIN.versacommerce.de/admin/settings/apps)

    $ bin/versacommerce add YOUR-VERSACOMMERCE-DOMAIN (enter APP-Key and password)
    $ bin/versacommerce console
    irb(main):001:0> VersacommerceAPI::Shop.current

## Sample code:

    require "rubygems"
    require "versacommerce_api"

    # instantiate a session that is ready to make calls to the given shop.
    VersacommerceAPI::Session.setup(api_key: "API_KEY_FOR_APP", secret: "SHARED_SECRET_FOR_APP")
    
    # If your app is resistered with you shop, you can request the "registration-token" 
    token    = VersacommerceAPI::Session.request_token("api-test.versacommerce.de")
    
    # Instantiate a session that is ready to make calls to the given shop.
    session  = VersacommerceAPI::Session.new("shopdomain.versacommerce.de", "RECEIVED_TOKEN")
    session.valid?  # returns true
    
    # Now you can activate the session and you’re set:
    VersacommerceAPI::Base.activate_session(session)

    # Get data from that shop (returns ActiveResource instances):
    shop = VersacommerceAPI::Shop.current
    
    # Get three products:
    products = VersacommerceAPI::Product.find(:all, :params => {:limit => 3})
    
    # Get some orders:
    latest_orders = VersacommerceAPI::Order.find(:all)
    
### Product


Get product count:

    VersacommerceAPI::Product.count
    => 18
    
Get product count including variants:

    VersacommerceAPI::Product.count("show_variants" => "true")
    => 21

Find all products:

    VersacommerceAPI::Product.find(:all, params: {limit: 3})

Find all products and variants (nested objects):

    VersacommerceAPI::Product.find(:all, params: {include: :variants})

Find all products and variants (not nested):

    VersacommerceAPI::Product.find(:all, params: {show_variants: true})
    
Fetch a product and the nested variants:

    VersacommerceAPI::Product.find(167357, params: {include: :variants})
    
Fetch a product and nested properties of that product:

    VersacommerceAPI::Product.find(167357, params: {include: :variants})

Fetch a product and the nested variants including properties of those products and variants:

    VersacommerceAPI::Product.find(167357, params: {include: [:variants, :properties]})

*Reference:*

* [Product](https://github.com/versacommerce/vc-api/blob/master/sections/product.md)
* [ProductImage](https://github.com/versacommerce/vc-api/blob/master/sections/product_image.md)
* [Variant](https://github.com/versacommerce/vc-api/blob/master/sections/variant.md)
* [Property](https://github.com/versacommerce/vc-api/blob/master/sections/property.md)

#### Receive products in batches

You can receive max 250 records per request. The default limit is 150. If you need to handle more records, you should request them in batches. Use the query params "limit" and "offset" to batch through your results.

Sample, receive all products and prints them.

      require "rubygems"
      require "versacommerce_api"

      products       = []
      products_count = VersacommerceAPI::Product.count("show_variants" => "true")
      num_batches    = (products_count.to_f / 200).ceil
      num_batches.times do |batch|
        puts  "Fetching products: Batch #{batch+1} of #{num_batches}"
        products.concat VersacommerceAPI::Product.find(:all, params: {limit: 200, offset: batch*200, show_variants: true})
      end
      
      products.each do |product|
        puts "product code : #{product.code}"
        puts "product title: #{product.title}"
      end

### Order

    VersacommerceAPI::Order.find(:all, :params => {:limit => 3})
    VersacommerceAPI::Customer.find(:all, :params => {:limit => 3, :include => :billing_address})

*Reference:*

* [Order](https://github.com/versacommerce/vc-api/blob/master/sections/order.md)
* [Item](https://github.com/versacommerce/vc-api/blob/master/sections/item.md)
* [Customer](https://github.com/versacommerce/bcx-api/blob/master/sections/custimer.md)
* [BillingAddress](https://github.com/versacommerce/bcx-api/blob/master/sections/billing_address.md)
* [ShippingAddress](https://github.com/versacommerce/vc-api/blob/master/sections/shipping_address.md)
* [Shipment](https://github.com/versacommerce/vc-api/blob/master/sections/shipment.md)
* [Payment](https://github.com/versacommerce/vc-api/blob/master/sections/payment.md)

### Customer

    c = VersacommerceAPI::Customer.find(18451)
    c.option_01 = "test"
    c.save

### Page

    VersacommerceAPI::Page.find(:all).first

    => {
      "active"=>true,
      "title"=>"AGB",
      "content"=>"<p>This is some Text</p>",
      "content_meta_description"=>"This is a special page.",
      "content_meta_keywords"=>"kewords, supported",
      "content_title_tag"=>"Search engine optimized title",
      "custom_url"=>nil,
      "custom_url_routing"=>"standard_url_is_canonical",
      "format"=>"tinymce",
      "handle"=>"this-is-a-special-page",
      "id"=>9070,
      "option_01"=>nil,
      "option_02"=>nil,
      "option_03"=>nil,
      "properties_count"=>0,
      "mall_id"=>nil,
      "shop_id"=>1157,
      "created_on"=>Mon, 10 Sep 2013,
      "updated_on"=>Mon, 10 Sep 2013
      }

*Reference:*

* [Page](https://github.com/versacommerce/vc-api/blob/master/sections/page.md)

## TODO

* Add more resources
* More documentation
* More Specs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
