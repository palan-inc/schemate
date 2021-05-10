# Schemate [![Build Status](https://travis-ci.org/eishis/schemate.svg?branch=master)](https://travis-ci.org/eishis/schemate) [![Coverage Status](https://coveralls.io/repos/github/eishis/schemate/badge.svg?branch=master)](https://coveralls.io/github/eishis/schemate?branch=master)

Export current schema of ActiveRecord models as markdown or CSV

The schema list (schemate.md) looks like this:
```
# Table name: `users` 
## Columns
|FieldName |Attitutde |Size |NULL |Default |Comment |
|---|---|---|---|---|---|
|id |integer |8 |false | ||
|name |string |255 |true | ||
|email |string |255 |false | ||
|crypted_password |string |255 |true | ||
|salt |string |255 |true | ||
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schemate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schemate

## Usage

Export schema to CSV:

    $ bundle exec rake schemate:export_csv

Export schema to Markdown:

    $ bundle exec rake schemate:export_md

## Configuration
To generate a configuration file(config/initializers/schemate.rb), to set default options:

    $ rails g schemate:install

Edit this file to control auto generation, and output format.

By default, schema is exported only when you run `schemate:export_csv` or `schemate:export_md`.  
If you want to export schema automatically with `rake db:migrate`, edit the file and change:

    config.auto_generate = true

By default, auto generate file type is markdown.  
If you want to generate file as csv, edit the file and change:

    config.auto_generate_type = 'csv'

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/palan-inc/schemate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Schemate project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/palan-inc/schemate/blob/master/CODE_OF_CONDUCT.md).
