# VersacommerceAPI

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'versacommerce_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install versacommerce_api

## Usage

TODO: Write usage instructions here

    $ bin/versacommerce console

### SetUp the credentials:

    VersacommerceAPI::Session.setup(api_key: "API_KEY_FOR_APP", secret: "SHARED_SECRET_FOR_APP")
    session = VersacommerceAPI::Session.new("shopdomain.versacommerce.de", "RECEIVED_TOKEN")
    VersacommerceAPI::Base.activate_session(session)

    optional:
    
    VersacommerceAPI::Session.new("shopdomain.versacommerce.de").create_permission_url
    
### Product

    VersacommerceAPI::Product.find(:all, :params => {:limit => 3})

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
