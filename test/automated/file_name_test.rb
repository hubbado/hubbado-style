require_relative "../test_init"

# A launcher in libexec is named after the command in bin that runs it, and a command's name has
# dashes.
context "File Name" do
  def self.file_name_cop_names(path)
    offenses("# frozen_string_literal: true\n", path: File.expand_path(path, Dir.pwd))
      .map(&:cop_name)
      .grep("Naming/FileName")
  end

  context "Launcher in libexec named after its command" do
    cop_names = file_name_cop_names("libexec/advanced-billing.rb")

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Library file with dashes" do
    cop_names = file_name_cop_names("lib/advanced-billing.rb")

    test "Flagged" do
      assert(cop_names == ["Naming/FileName"])
    end
  end

  # RuboCop's own default; setting an Exclude replaces the default list rather than adding to it.
  context "Rakefile.rb" do
    cop_names = file_name_cop_names("Rakefile.rb")

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end
end
