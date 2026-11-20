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

The same rule applies to a method call without brackets: if the arguments do not all fit on one line, each argument goes on a line of its own. The first argument stays on the line of the method name.

Rationale: A mixture of related horizontal and vertical information is harder to scan.

```ruby
# bad
cell Somecell, model,
  option_one: value_one, option_two: value_two

# good
cell Somecell,
  model,
  option_one: value_one,
  option_two: value_two
```

Options are arguments too, so each goes on a line of its own:

```ruby
instance_double SomeObject,
  property_one: some_value,
  property_two: some_other_value
```

### Arrays and hashes

The same rule applies to the entries of an array or a hash: all on one line, or one entry per line.

```ruby
# bad
["add-to-job-description", "--deal-id", "rec_1",
 "--by", "Sam Stickland"]

# good
[
  "add-to-job-description",
  "--deal-id",
  "rec_1",
  "--by",
  "Sam Stickland"
]
```

`Layout/FirstArrayElementLineBreak`, `Layout/MultilineArrayLineBreaks`, `Layout/FirstHashElementLineBreak` and `Layout/MultilineHashKeyLineBreaks` enforce it.

### Arguments put on separate lines on purpose

A call whose arguments are one per line stays that way, even if they would fit on one line. So does an array, a hash or a chain of methods laid out one entry or one step per line to be read more easily. The configuration only reports arguments laid out halfway: some on the first line and the rest below it.

`Layout/FirstMethodArgumentLineBreak` and `Layout/MultilineMethodArgumentLineBreaks` enforce this for calls, and `Layout/FirstMethodParameterLineBreak` and `Layout/MultilineMethodParameterLineBreaks` for definitions. A last argument that runs over several lines is allowed after the opening bracket:

```ruby
expect(result).to eq({
  id: id,
  name: name
})
```
