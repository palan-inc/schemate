require 'csv'

namespace :schemate do
  desc 'Create CSV file from schema information'
  task export_csv: :environment do
    CSV.open('schemate.csv', 'w') do |file|
      ActiveRecord::Base.connection.tables.each do |table|
        next if table.in?(%w(schema_migrations ar_internal_metadata))
        file << %W(#{table})
        file << %w(FieldName Attitutde Size NULL Default Comment)
        Module.const_get(table.classify).columns.each do |columns|
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
    File.open('schemate.md', 'w') do |file|
      ActiveRecord::Base.connection.tables.each do |table|
        next if table.in?(%w(schema_migrations ar_internal_metadata))
        file.puts("# Table name: `#{table}` \n")
        file.puts('## Columns')
        file.puts('|FieldName |Attitutde |Size |NULL |Default |Comment |')
        file.puts('|---|---|---|---|---|---|')
        Module.const_get(table.classify).columns.each do |columns|
          file.puts("|#{columns.name} |#{columns.type} |#{columns.limit} |#{columns.null} |#{columns.default} |#{columns.comment}|")
        end
        file.puts("\n")
      end
    end
    puts 'complete! See schemate.md!'
  end
end
