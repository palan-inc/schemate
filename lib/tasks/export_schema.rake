desc 'Get schema information from database'
task export_schema: :environment do
  ActiveRecord::Base.connection.tables.each do |table|
    next if table.in?(['schema_migrations', 'ar_internal_metadata'])
    p "---------------"
    p "table_name:#{table}"
    Module.const_get(table.classify).columns.each do |columns|
      p "name:#{columns.name}"
      p "  type:#{columns.type}"
      p "  limit:#{columns.limit}"
      p "  null:#{columns.null}"
      p "  default:#{columns.default}"
    end
    p "---------------"
  end
end
