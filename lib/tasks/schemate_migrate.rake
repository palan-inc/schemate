namespace :db do
  [:migrate, :rollback].each do |cmd|
    task cmd do
      File.open('schemate.md', 'w') do |file|
        ActiveRecord::Base.connection.tables.each do |table|
          next if table.in?(%w(schema_migrations ar_internal_metadata))
          puts "#{table}"
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
    end

    namespace cmd do
      [:change, :up, :down, :reset, :redo].each do |t|
        task t do
          File.open('schemate.md', 'w') do |file|
            ActiveRecord::Base.connection.tables.each do |table|
              next if table.in?(%w(schema_migrations ar_internal_metadata))
              puts "#{table}"
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
        end
      end
    end
  end
end
