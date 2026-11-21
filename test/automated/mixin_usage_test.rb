require_relative "../test_init"

# A test's init file includes the namespace under test at the top level, so its tests can name
# the classes without it.
context "Mixin Usage" do
  def self.mixin_cop_names(source, path:)
    offenses(source, path: File.expand_path(path, Dir.pwd))
      .map(&:cop_name)
      .grep("Style/MixinUsage")
  end

  source = <<~RUBY
    include HubbadoAttio
  RUBY

  context "Top-level include in a test's init file" do
    cop_names = mixin_cop_names(source, path: "test/automated/automated_init.rb")

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Top-level include in a library file" do
    cop_names = mixin_cop_names(source, path: "lib/hubbado_attio.rb")

    test "Flagged" do
      assert(cop_names == ["Style/MixinUsage"])
    end
  end
end
