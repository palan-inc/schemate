require "spec_helper"
require 'schemate'

RSpec.describe Schemate do
  it "has a version number" do
    expect(Schemate::VERSION).not_to be nil
  end

  def mock_column(name, type, options = {})
    default_options = {
      limit: nil,
      null: false,
      default: nil
    }

    stubs = default_options.dup
    stubs.merge!(options)
    stubs[:name] = name
    stubs[:type] = type

    double('Column', stubs)
  end

  describe "Schemate#csv_row" do
    it do
      column = mock_column(:id, :integer, limit: 8, comment: 'ID')
      expect(Schemate.csv_row(column, 'true')).to eq(["id", "integer", "8", "false", "", "true", "ID"])
    end
  end

  describe "Schemate#markdown_row" do
    it do
      column = mock_column(:id, :integer, limit: 8, comment: 'ID')
      expect(Schemate.md_row(column, 'true')).to eq("|id |integer |8 |false | |true |ID |")
    end
  end
end
