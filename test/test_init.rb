# Lets a test lint a piece of source with default.yml and read the offenses
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

# The source as `rubocop -a` leaves it, with default.yml
def corrected(source)
  require "tmpdir"

  Dir.mktmpdir do |directory|
    path = File.join(directory, "example.rb")
    File.write(path, source)
    config = File.expand_path("../default.yml", __dir__)
    system(
      "bundle",
      "exec",
      "rubocop",
      "--config",
      config,
      "-a",
      "--format",
      "quiet",
      path,
      out: File::NULL,
      err: File::NULL
    )
    File.read(path)
  end
end
