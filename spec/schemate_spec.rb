require "spec_helper"
require 'schemate'

RSpec.describe Schemate do
  it "has a version number" do
    expect(Schemate::VERSION).not_to be nil
  end

  def mock_class(table_name, primary_key, columns, indexes = [], foreign_keys = [])
    options = {
      connection:       mock_connection(indexes, foreign_keys),
      table_exists?:    true,
      table_name:       table_name,
      primary_key:      primary_key,
      column_names:     columns.map { |col| col.name.to_s },
      columns:          columns,
      column_defaults:  Hash[columns.map { |col| [col.name, col.default] }],
      table_name_prefix: ''
    }

    double('An ActiveRecord class', options)
  end

  def mock_connection(indexes = [], foreign_keys = [])
    double('Conn',
           indexes:      indexes,
           foreign_keys: foreign_keys,
           supports_foreign_keys?: true)
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
end
