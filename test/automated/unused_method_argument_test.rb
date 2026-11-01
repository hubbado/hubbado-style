require_relative "../test_init"

context "Unused Method Argument" do
  context "Recorded Method" do
    unused_argument_offenses = offenses(<<~RUBY).map(&:cop_name).grep(/UnusedMethodArgument/)
      record def call(assignment, rate:) = result
    RUBY

    test "Not flagged" do
      assert(unused_argument_offenses.empty?)
    end
  end

  context "Method" do
    unused_argument_offenses = offenses(<<~RUBY).map(&:cop_name).grep(/UnusedMethodArgument/)
      def call(assignment, rate:) = result
    RUBY

    test "Each unused argument is flagged once" do
      assert(unused_argument_offenses == ["Hubbado/UnusedMethodArgument"] * 2)
    end
  end

  context "Empty Method" do
    unused_argument_offenses = offenses(<<~RUBY).map(&:cop_name).grep(/UnusedMethodArgument/)
      def call(assignment, rate:); end
    RUBY

    test "Not flagged" do
      assert(unused_argument_offenses.empty?)
    end
  end
end
