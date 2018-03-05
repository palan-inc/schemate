require 'csv'

desc 'Get schema information from database'
task export_schema: :environment do
  CSV.open('schemate.csv', 'w') do |file|
    ActiveRecord::Base.connection.tables.each do |table|
      next if table.in?(%w(schema_migrations ar_internal_metadata))
      p "table_name:#{table}"

      file << %W(#{table})
      file << %w(name type limit null default comment)
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
