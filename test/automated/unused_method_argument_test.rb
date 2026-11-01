require_relative "../test_init"

context "Unused Method Argument" do
  context "Recorded Method" do
    cop_names = unused_argument_cop_names(<<~RUBY)
      record def call(assignment, rate:) = result
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Method" do
    cop_names = unused_argument_cop_names(<<~RUBY)
      def call(assignment, rate:) = result
    RUBY

    test "Each unused argument is flagged once" do
      assert(cop_names == ["Hubbado/UnusedMethodArgument"] * 2)
    end
  end

  context "Empty Method" do
    cop_names = unused_argument_cop_names(<<~RUBY)
      def call(assignment, rate:); end
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end
end
