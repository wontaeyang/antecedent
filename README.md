# Antecedent

In some cases it is not desirable to retrieve STI
classes in polymorphic relation and having scopes to
filter by type column is good enough. (ex: I had to create
a read only client API app that retrieves records
from existing Rails DB). This gem was created to
override default behavior of ActiveRecord
`BelongsToPolymorphicAssociation`
and return association in its base classes.

It supports polymorphic type columns with base class names (ex: "User")
and full class name (ex: "User::Admin").

TODO: Add support for other AR versions (current version is only for 5.2)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'antecedent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install antecedent

## Usage

to disable entirely add following line in `config/initializers/antecedent.rb`:

```
Antecedent.disable_sti
```

using a wrapper method:

```
def without_sti
  Antecedent.disable_sti
  yield
  Antecedent.enable_sti
end

without_sti do
  #your code here
end
```

to allow STI in some models while disabled, add following:

```
class User < ActiveRecord::Base
  self.inheritance_column = :type
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Test

setup test db

```
rake db:setup db:migrate RAILS_ENV=test
```

run spec:

```
rspec .
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/antecedent.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
