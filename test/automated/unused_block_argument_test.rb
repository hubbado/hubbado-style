require_relative "../test_init"

context "Unused Block Argument" do
  def self.block_argument_cop_names(source)
    offenses(source).map(&:cop_name).grep(/UnusedBlockArgument/)
  end

  # The block's parameter list is the signature of the template method, read as its contract.
  context "Block given to template_method" do
    cop_names = block_argument_cop_names(<<~RUBY)
      cls.template_method(:call) do |query_spec:, result_limit: nil|
        raise TemplateMethod::Error, "Implementation is required (Method name: call)"
      end
    RUBY

    test "Not flagged" do
      assert(cop_names.empty?)
    end
  end

  context "Block given to another method" do
    cop_names = block_argument_cop_names(<<~RUBY)
      rows.each do |row, index|
        puts row
      end
    RUBY

    test "Each unused argument is flagged once" do
      assert(cop_names == ["Hubbado/UnusedBlockArgument"])
    end

    test "Flagged as a warning" do
      offense = offenses(<<~RUBY).find { |o| o.cop_name == "Hubbado/UnusedBlockArgument" }
        rows.each { |row, index| puts row }
      RUBY

      assert(offense.severity.name == :warning)
    end
  end

  context "Empty block" do
    cop_names = block_argument_cop_names(<<~RUBY)
      rows.each { |row| }
    RUBY

    test "Not flagged, as RuboCop's own cop does not flag it" do
      assert(cop_names.empty?)
    end
  end
end
