require "bundler/setup"
require "rubocop"
require "test_bench"
TestBench.activate

CONFIG = RuboCop::ConfigLoader.configuration_from_file(File.expand_path("../default.yml", __dir__))

def offenses(source)
  registry = RuboCop::Cop::Registry.global

  processed_source = RuboCop::ProcessedSource.new(source, CONFIG.target_ruby_version, "example.rb")
  processed_source.config = CONFIG
  processed_source.registry = registry

  team = RuboCop::Cop::Team.mobilize(registry, CONFIG, raise_error: true)
  team.investigate(processed_source).offenses
end

def unused_argument_cop_names(source)
  offenses(source).map(&:cop_name).grep(/UnusedMethodArgument/)
end
