# RailsDbConfigResolver

Resolves database configuration in the same way that rails does.
This is useful when wanting to connect to rail's database without loading the rails environment or
when wanting to use [em-pg-client][1] for a helper process in a rails app.

Values from `ENV['DATABASE_URL']` and `config/database.yml` are merged. `ENV['DATABASE_URL']` trumps `config/database.yml`.
By looking at [the rails guide][2], I _think_ the url field in `database.yml` trumps both of them, so I'm not sure, so I left it out.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_db_config_resolver'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_db_config_resolver

## Usage

For now, check out `spec/rails_db_config_resolver_spec.rb`.

## Contributing

1. Fork it ( https://github.com/cameron-martin/rails_db_config_resolver/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[1]: https://github.com/royaltm/ruby-em-pg-client
[2]: http://guides.rubyonrails.org/configuring.html#configuring-a-database