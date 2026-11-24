require_relative "../test_init"

# A test's or context's name stays on one line, however long, so the name TestBench prints on a
# failure can be found in the source.
context "Line Length" do
  def self.line_length_cop_names(source)
    offenses(source).map(&:cop_name).grep("Layout/LineLength")
  end

  long_name = "the worker for another step leaves it: the automation fields describe one step " \
              "at a time, and the step after it reads them again"

  context "Long test name" do
    cop_names = line_length_cop_names(<<~RUBY)
      test "#{long_name}" do
      end
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Long context name" do
    cop_names = line_length_cop_names(<<~RUBY)
      context "#{long_name}" do
      end
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Long string that is not a test or context name" do
    cop_names = line_length_cop_names(<<~RUBY)
      message = "#{long_name}"
    RUBY

    test "Flagged" do
      assert(cop_names == ["Layout/LineLength"])
    end
  end

  context "Long test name followed by code on the same line" do
    cop_names = line_length_cop_names(<<~RUBY)
      test "a short name" do assert(#{long_name.split.first(12).map { |word| "#{word.delete(',:')}?" }.join(' && ')}) end
    RUBY

    test "Flagged" do
      assert(cop_names == ["Layout/LineLength"])
    end
  end
end
