namespace :db do
  [:migrate, :rollback].each do |cmd|
    task cmd do
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
    end

    namespace cmd do
      [:change, :up, :down, :reset, :redo].each do |t|
        task t do
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
        end
      end
    end
  end
end
