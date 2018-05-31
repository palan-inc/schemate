require "schemate/version"

module Schemate
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/export_schema.rake"
      load "tasks/schemate_migrate.rake"
    end
  end

  class << self
    def export(format:)
      return if format.nil?

      Rails.application.eager_load!
      export_as(format)
      puts_complete_message(format)
    end

    private

    def export_as(format)
      if format == 'csv'
        export_csv
      elsif format == 'md'
        export_md
      end
    end

    def export_csv
      CSV.open('schemate.csv', 'w') do |file|
        ActiveRecord::Base.descendants.each do |model|
          model_name = model.name
          table_name = model_name.tableize

          next unless tables.include?(table_name)
          file << %W(#{table_name})
          file << %w(FieldName Attitutde Size NULL Default Comment)
          model.columns.each do |columns|
            file << %W(
              #{columns.name} #{columns.type} #{columns.limit}
              #{columns.null} #{columns.default} #{columns.comment}
            )
          end
          file << %w()
        end
      end
    end

    def export_md
      File.open('schemate.md', 'w') do |file|
        ActiveRecord::Base.descendants.each do |model|
          model_name = model.name
          table_name = model_name.tableize

          next unless tables.include?(table_name)
          file.puts("# Table name: `#{table_name}` \n")
          file.puts('## Columns')
          file.puts('|FieldName |Attitutde |Size |NULL |Default |Comment |')
          file.puts('|---|---|---|---|---|---|')
          model.columns.each do |columns|
            file.puts("|#{columns.name} |#{columns.type} |#{columns.limit} |#{columns.null} |#{columns.default} |#{columns.comment}|")
          end
          file.puts("\n")
        end
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
