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

The inherited rubocop canfiguration can be overridden in the `.rubocop.yml` but this is discouraged.

Now, run:

```bash
$ bundle exec rubocop
```

You do not need to include rubocop directly in your application's dependencies. Hubbado-style will include a specific version of `rubocop` and `rubocop-rspec` that is shared across all projects.

Bug reports and pull requests are welcome on GitHub at https://github.com/hubbado/hubbado-style.

## Styleguide

The Rubocop configuration should guide you most of the way, but there are somethings that we haven't been able to configure in Rubocop, which are detailed below.

### Long lists of arguments

If a  list of related arguments cannot fit on a single line, then each argument should be placed on it's own line.

Rationale: A mixture of related horizontal and vertical information is harder to scan.

```ruby
# bad
some_method(
  long_argument1: value1, long_argument2: value2, long_argument3: value3, long_argument4: value4,
  long_argument5: value5
)

# good
some_method(
  long_argument1: value1,
  long_argument2: value2,
  long_argument3: value3,
  long_argument4: value4,
  long_argument5: value5
)
```

### Multiline bracketed method calls 

Do not place method arguments next to the opening bracket if all the arguments do not fit on one line.

Rationale: A mixture of related horizontal and vertical information is harder to scan.


```ruby
# bad
some_method(arg1,
  arg2, arg3, arg4)

#good
some_method(
  arg1, arg2, arg3, arg4
)
```

### Methods calls without brackets

If the method call does not use brackets, different types of arguments can be placed one different lines. If the full set of related arguments does not fit on one line they should be placed one per line.

For example, in the following method calls the first method argument is the principle, and most important argument.

```ruby
cell Somecell, model,
  option_one: value_one, option_two: value_two, ...
```

```ruby
instance_double SomeObject,
  property_one: some_value,
  property_two: some_other_value
```
