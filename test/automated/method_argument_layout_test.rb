require_relative "../test_init"

# A call's arguments go on one line, or all on one line inside the brackets, or one per line.
context "Method Argument Layout" do
  def self.layout_cop_names(source)
    offenses(source).map(&:cop_name).grep(%r{\ALayout/(First|Multiline)MethodArgument}).uniq.sort
  end

  context "Arguments on the first line, and the rest on lines below" do
    cop_names = layout_cop_names(<<~RUBY)
      Queueing.search_key(deal_id: "rec_1", searcher: SEARCHER,
        enrichment_version: VERSION,
        jd_hash: HASH)
    RUBY

    test "Flagged" do
      assert(cop_names == %w[
        Layout/FirstMethodArgumentLineBreak
        Layout/MultilineMethodArgumentLineBreaks
      ])
    end
  end

  context "Main arguments together, and the options together on the next line, without brackets" do
    cop_names = layout_cop_names(<<~RUBY)
      cell Somecell, model,
        option_one: value_one, option_two: value_two
    RUBY

    test "Flagged" do
      assert(cop_names == ["Layout/MultilineMethodArgumentLineBreaks"])
    end
  end

  context "One argument per line" do
    cop_names = layout_cop_names(<<~RUBY)
      Queueing.search_key(
        deal_id: "rec_1",
        searcher: SEARCHER
      )
    RUBY

    test "Not flagged, even where it would fit on one line" do
      assert(cop_names.empty?)
    end
  end

  context "All arguments on one line inside the brackets" do
    cop_names = layout_cop_names(<<~RUBY)
      some_method(
        arg1, arg2, arg3, arg4
      )
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Arguments on one line, the last of them over several lines" do
    cop_names = layout_cop_names(<<~RUBY)
      expect(result).to eq({
        id: id,
        name: name
      })
      assert(cop_names == %w[
        Layout/FirstMethodArgumentLineBreak
      ])
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "One option per line, without brackets" do
    cop_names = layout_cop_names(<<~RUBY)
      instance_double SomeObject,
        property_one: some_value,
        property_two: some_other_value
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end
end
