require_relative "../test_init"

# An array's or a hash's entries go all on one line, or one entry per line.
context "Array and Hash Layout" do
  def self.layout_cop_names(source)
    offenses(source).map(&:cop_name).grep(%r{\ALayout/(First|Multiline)(Array|Hash)}).uniq.sort
  end

  context "Array" do
    context "Entries on the first line, and the rest on lines below" do
      cop_names = layout_cop_names(<<~RUBY)
        ["add-to-job-description", "--deal-id", "rec_1",
         "--by", "Sam Stickland"]
      RUBY

      test "Flagged" do
        assert(cop_names == %w[
          Layout/FirstArrayElementLineBreak
          Layout/MultilineArrayLineBreaks
        ])
      end
    end

    context "All entries on one line inside the brackets" do
      cop_names = layout_cop_names(<<~RUBY)
        [
          "add-to-job-description", "--deal-id", "rec_1"
        ]
      RUBY

      test "Not flagged" do
        assert(cop_names.empty?)
      end
    end

    context "One entry per line" do
      cop_names = layout_cop_names(<<~RUBY)
        [
          "add-to-job-description",
          "--deal-id"
        ]
      RUBY

      test "Not flagged, even where it would fit on one line" do
        assert(cop_names.empty?)
      end
    end

    context "All entries on one line" do
      cop_names = layout_cop_names(<<~RUBY)
        ["add-to-job-description", "--deal-id", "rec_1"]
      RUBY

      test "Not flagged" do
        assert(cop_names.empty?)
      end
    end

    context "Entries on one line, the last of them over several lines" do
      cop_names = layout_cop_names(<<~RUBY)
        [first, {
          id: id
        }]
      RUBY

      test "Not flagged" do
        assert(cop_names.empty?)
      end
    end
  end

  context "Hash" do
    context "Entries on the first line, and the rest on lines below" do
      cop_names = layout_cop_names(<<~RUBY)
        { "tags" => tags, "as_of_dates" => dates,
          "page" => page }
      RUBY

      test "Flagged" do
        assert(cop_names == %w[
          Layout/FirstHashElementLineBreak
          Layout/MultilineHashKeyLineBreaks
        ])
      end
    end

    context "All entries on one line inside the braces" do
      cop_names = layout_cop_names(<<~RUBY)
        {
          "tags" => tags, "page" => page
        }
      RUBY

      test "Not flagged" do
        assert(cop_names.empty?)
      end
    end

    context "One entry per line" do
      cop_names = layout_cop_names(<<~RUBY)
        {
          "tags" => tags,
          "page" => page
        }
      RUBY

      test "Not flagged, even where it would fit on one line" do
        assert(cop_names.empty?)
      end
    end

    context "All entries on one line" do
      cop_names = layout_cop_names(<<~RUBY)
        { "tags" => tags, "page" => page }
      RUBY

      test "Not flagged" do
        assert(cop_names.empty?)
      end
    end
  end
end
