# hubbado-style

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hubbado/style`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby

group :test, :development do
  gem 'hubbado-style'
end
```

Or, for a Ruby library, add this to your gemspec:

```ruby
spec.add_development_dependency 'hubbado-style'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubbado-style

## Usage

Create a `.rubocop.yml` with the following directives:

```yaml
inherit_gem:
  hubbado-style:
    - default.yml
```

Now, run:

```bash
$ bundle exec rubocop
```

You do not need to include rubocop directly in your application's dependencies. Hubbado-style will include a specific version of `rubocop` and `rubocop-rspec` that is shared across all projects.

Bug reports and pull requests are welcome on GitHub at https://github.com/hubbado/hubbado-style.
