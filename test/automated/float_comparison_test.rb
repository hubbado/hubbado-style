require_relative "../test_init"

# A test compares a value with the literal it expects, so exact equality is the check it means;
# a float that differs shows as a failing test. In library code a wrong comparison stays silent.
context "Float Comparison" do
  def self.float_comparison_cop_names(path)
    source = "# frozen_string_literal: true\n\nassert(config.boost == 6.0)\n"

    offenses(source, path: File.expand_path(path, Dir.pwd))
      .map(&:cop_name)
      .grep("Lint/FloatComparison")
  end

  context "In a test" do
    cop_names = float_comparison_cop_names("test/automated/config.rb")

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "In library code" do
    cop_names = float_comparison_cop_names("lib/config.rb")

    test "Flagged" do
      assert(cop_names == ["Lint/FloatComparison"])
    end
  end
end
