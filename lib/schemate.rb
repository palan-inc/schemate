require "schemate/version"

module Schemate
  if defined?(::Rails::Railtie)
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/export_schema.rake"
        load "tasks/schemate_migrate.rake"
      end
    end
  end

  class << self
    def export(format:)
      return if format.nil?

      Rails.application.eager_load!
      begin
        export_as(format)
      rescue StandardError => ex
        STDERR.puts "Unable to export : #{ex.message}"
        return
      end
      puts_complete_message(format)
    end

    def export_csv
      CSV.open('schemate.csv', 'w') do |file|
        ActiveRecord::Base.descendants.each do |model|
          model_name = model.name
          table_name = model_name.tableize

          next unless tables.include?(table_name)
          file << %W(#{table_name})
          file << %w(FieldName Attitutde Size NULL Default Index Comment)
          model.columns.each do |columns|
            index = 'true' if model.connection.index_exists?(:"#{table_name}", :"#{columns.name}")
            file << csv_row(columns, index)
          end
          file << %w()
        end
      end
    end

    def csv_row(columns, index)
      %W(
        #{columns.name} #{columns.type} #{columns.limit}
        #{columns.null} #{columns.default} #{index} #{columns.comment}
      )
    end

    def export_md
      File.open('schemate.md', 'w') do |file|
        ActiveRecord::Base.descendants.each do |model|
          model_name = model.name
          table_name = model_name.tableize

          next unless tables.include?(table_name)
          file.puts("# Table name: `#{table_name}`\n")
          file.puts('## Columns')
          file.puts('|FieldName |Attitutde |Size |NULL |Default |Index |Comment |')
          file.puts('|---|---|---|---|---|---|---|')
          model.columns.each do |columns|
            index = 'true' if model.connection.index_exists?(:"#{table_name}", :"#{columns.name}")
            file.puts(md_row(columns, index))
          end
          file.puts("\n")
        end
      end
    end

    def md_row(columns, index)
      "|#{columns.name} |#{columns.type} |#{columns.limit} |#{columns.null} |#{columns.default} |#{index} |#{columns.comment} |"
    end

    private

    def export_as(format)
      if format == 'csv'
        export_csv
      elsif format == 'md'
        export_md
      end
    end

    def tables
      @tables ||= ActiveRecord::Base.connection.tables
    end

    def puts_complete_message(format)
      puts "complete! See schemate.#{format}!"
    end
  end
end
