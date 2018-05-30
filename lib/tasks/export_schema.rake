require 'csv'

namespace :schemate do
  desc 'Create CSV file from schema information'
  task export_csv: :environment do
    Rails.application.eager_load!
    tables = ActiveRecord::Base.connection.tables

    CSV.open('schemate.csv', 'w') do |file|
      ActiveRecord::Base.descendants.each do |model|
        next unless tables.include?(model.name.tableize)
        file << %W(#{model.name.tableize})
        file << %w(FieldName Attitutde Size NULL Default Comment)
        model.columns.each do |columns|
          file << %W(
            #{columns.name} #{columns.type} #{columns.limit}
            #{columns.null} #{columns.default} #{columns.comment}
          )
        end
        file << %w()
        puts 'complete! See schemate.csv!'
      end
    end
  end

  desc 'Create Markdown file from schema information'
  task export_md: :environment do
    Rails.application.eager_load!
    tables = ActiveRecord::Base.connection.tables

    File.open('schemate.md', 'w') do |file|
      ActiveRecord::Base.descendants.each do |model|
        next unless tables.include?(model.name.tableize)
        file.puts("# Table name: `#{model.name.tableize}` \n")
        file.puts('## Columns')
        file.puts('|FieldName |Attitutde |Size |NULL |Default |Comment |')
        file.puts('|---|---|---|---|---|---|')
        model.columns.each do |columns|
          file.puts("|#{columns.name} |#{columns.type} |#{columns.limit} |#{columns.null} |#{columns.default} |#{columns.comment}|")
        end
        file.puts("\n")
      end
    end
    puts 'complete! See schemate.md!'
  end
end
