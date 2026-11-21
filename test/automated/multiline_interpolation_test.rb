require_relative "../test_init"

# An interpolation runs on one line: a value too long for that is named before the string.
context "Multiline Interpolation" do
  def self.interpolation_cop_names(source)
    offenses(source).map(&:cop_name).grep("Hubbado/MultilineInterpolation")
  end

  context "A call broken over lines inside an interpolation" do
    cop_names = interpolation_cop_names(<<~'RUBY')
      "the Hubbado server refused #{tool}: #{result.dig(
        "content",
        0
      )}"
    RUBY

    test "Flagged" do
      assert(cop_names == ["Hubbado/MultilineInterpolation"])
    end
  end

  context "A block over lines inside an interpolation" do
    cop_names = interpolation_cop_names(<<~'RUBY')
      puts "  strongest first: #{placed.map do |row|
        row.fetch("name")
      end.join(", ")}"
    RUBY

    test "Flagged" do
      assert(cop_names == ["Hubbado/MultilineInterpolation"])
    end
  end

  context "Interpolations on one line, in a string continued over lines" do
    cop_names = interpolation_cop_names(<<~'RUBY')
      "the Hubbado server refused #{tool}: " \
        "#{reason}"
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Interpolations on one line, in a heredoc" do
    cop_names = interpolation_cop_names(<<~'RUBY')
      text = <<~TEXT
        refused #{tool}
        because #{reason}
      TEXT
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end
end
