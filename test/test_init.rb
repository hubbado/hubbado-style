require "bundler/setup"
require "rubocop"
require "test_bench"
TestBench.activate

CONFIG = RuboCop::ConfigLoader.configuration_from_file(File.expand_path("../default.yml", __dir__))

def offenses(source)
  processed_source = RuboCop::ProcessedSource.new(source, CONFIG.target_ruby_version, "example.rb")
  processed_source.config = CONFIG
  processed_source.registry = RuboCop::Cop::Registry.global

  team = RuboCop::Cop::Team.mobilize(RuboCop::Cop::Registry.global, CONFIG, raise_error: true)
  team.investigate(processed_source).offenses
end
