# VersacommerceAPI

TODO: Write a gem description

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

## Sample code:

    require "rubygems"
    require "versacommerce_api"

    VersacommerceAPI::Session.setup(api_key: "API_KEY_FOR_APP", secret: "SHARED_SECRET_FOR_APP")
    token    = VersacommerceAPI::Session.request_token("api-test.versacommerce.de")
    session  = VersacommerceAPI::Session.new("shopdomain.versacommerce.de", "RECEIVED_TOKEN")
    VersacommerceAPI::Base.activate_session(session)

    products = VersacommerceAPI::Product.find(:all, :params => {:limit => 3})
    
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

### Customer

    c = VersacommerceAPI::Customer.find(18451)
    c.option_01 = "test"
    c.save

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
