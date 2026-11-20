# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

# [1.9.0 - 2026-11-20]
## Changed
- Layout/FirstArrayElementLineBreak, Layout/MultilineArrayLineBreaks,
  Layout/FirstHashElementLineBreak and Layout/MultilineHashKeyLineBreaks
  enabled, with AllowMultilineFinalElement: an array's or a hash's entries go
  all on one line, or one entry per line. An array or hash laid out one entry
  per line on purpose is not joined

## Migration
- Run `rubocop -a --only Layout/FirstArrayElementLineBreak,
  Layout/MultilineArrayLineBreaks,Layout/FirstHashElementLineBreak,
  Layout/MultilineHashKeyLineBreaks` (as one argument, without spaces).
  Every offence of the four cops can be corrected automatically

# [1.8.0 - 2026-11-20]
## Changed
- Layout/FirstMethodArgumentLineBreak and
  Layout/MultilineMethodArgumentLineBreaks enabled, with
  AllowMultilineFinalElement: a call's arguments go on one line, all on one
  line inside the brackets, or one per line. A call laid out one per line on
  purpose is not joined
- README: a call without brackets puts each argument on a line of its own
  when they do not all fit on one line; the example with the options together
  on the second line is now the bad one

## Migration
- Run `rubocop -a --only
  Layout/FirstMethodArgumentLineBreak,Layout/MultilineMethodArgumentLineBreaks`.
  Every offence of the two cops can be corrected automatically

# [1.7.0 - 2026-11-20]
## Changed
- Layout/BlockEndNewline enabled, in specs too: a block's `end` or `}` on the
  line of its body is an offence, so `rubocop -a` can no longer leave
  `do |x|` followed by a body and `end` on one line

## Migration
- Run `rubocop -a --only Layout/BlockEndNewline`. The spec style
  `let(:x) { Foo.call(` ... `) }` is an offence now; the correction puts the
  `}` on its own line

# [1.6.0 - 2026-11-01]
## Added
- Hubbado/UnusedMethodArgument, which replaces Lint/UnusedMethodArgument and
  ignores the arguments of a `record def`
- Layout/FirstMethodParameterLineBreak and
  Layout/MultilineMethodParameterLineBreaks enabled
- Settings from hubbado_core: SuggestExtensions, Metrics/ModuleLength,
  Naming/AccessorMethodName, Naming/VariableNumber, Style/Alias,
  Style/EmptyClassDefinition, Style/FloatDivision, Style/HashAsLastArrayItem
  and Lint/AmbiguousOperatorPrecedence disabled; Naming/BlockForwarding
  explicit; Style/ArgumentsForwarding not anonymous;
  Lint/UnusedMethodArgument not autocorrected; Style/FormatStringToken and
  Lint/ConstantDefinitionInBlock skip specs

## Changed
- Layout/ParameterAlignment uses with_fixed_indentation
- Style/HashSyntax EnforcedShorthandSyntax is either_consistent
- Target ruby version 4.0

## Migration
- Rename a `.rubocop.yml` override of Lint/UnusedMethodArgument to
  Hubbado/UnusedMethodArgument
- Delete `# rubocop:disable Lint/UnusedMethodArgument` on a `record def`
  (`rubocop -a` does this), and rename it to Hubbado/UnusedMethodArgument on
  any other method

# [1.5.2 - 2025-06-16]
## Fixed
- Naming/PredicateName renamed to Naming/PredicatePrefix

# [1.5.1 - 2025-05-30]
- Bumped version to publish package in rubygems

# [1.5.0 - 2025-04-11]
## Changed
- Style/IfUnlessModifier disabled
- Target ruby version 3.4

# [1.4.0 - 2023-04-17]
## Added
- Disable Metrics/ParameterLists

# [1.3.0 - 2023-04-05]
## Changed
- Added EnforcedShorthandSyntax: never to Style/HashSyntax
- Target ruby version 3.2

# [1.2.0 - 2023-01-24]
## Changed
- Target ruby version 3.1

# [1.1.0 - 2020-03-16]
## Changed
- Do not report on Metrics/AbcSize, Metrics/BlockLength,
  Metrics/CyclomaticComplexity or Metrics/PerceivedComplexity

# [1.0.1 - 2021-04-10]
## Fixed
- Don't scan the gems directory

# [1.0.0 - 2021-04-10]
## Added
- Fix version of this gem, using our Rails monolith Rubocop configuration as a base
