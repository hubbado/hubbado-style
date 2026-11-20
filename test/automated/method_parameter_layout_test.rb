require_relative "../test_init"

# A definition's parameters go on one line, or all on one line inside the brackets, or one per
# line.
context "Method Parameter Layout" do
  def self.layout_cop_names(source)
    offenses(source).map(&:cop_name).grep(%r{\ALayout/(First|Multiline)MethodParameter}).uniq.sort
  end

  context "Parameters on the first line, and the rest on lines below" do
    cop_names = layout_cop_names(<<~RUBY)
      def search_key(deal_id:, searcher:,
        enrichment_version:,
        jd_hash:)
      end
    RUBY

    test "Flagged" do
      assert(cop_names == %w[
        Layout/FirstMethodParameterLineBreak
        Layout/MultilineMethodParameterLineBreaks
      ])
    end
  end

  context "One parameter per line" do
    cop_names = layout_cop_names(<<~RUBY)
      def search_key(
        deal_id:,
        searcher:
      )
      end
    RUBY

    test "Not flagged, even where it would fit on one line" do
      assert(cop_names.empty?)
    end
  end

  context "All parameters on one line inside the brackets" do
    cop_names = layout_cop_names(<<~RUBY)
      def search_key(
        deal_id:, searcher:, enrichment_version:, jd_hash:
      )
      end
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end
end
