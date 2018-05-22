# Schemate

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

    $ bundle exec rake export_schema

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eishis/schemate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Schemate project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eishis/schemate/blob/master/CODE_OF_CONDUCT.md).
