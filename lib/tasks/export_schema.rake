require 'csv'

namespace :schemate do
  desc 'Create CSV file from schema information'
  task export_csv: :environment do
    Schemate.export(format: 'csv')
  end

  desc 'Create Markdown file from schema information'
  task export_md: :environment do
    Schemate.export(format: 'md')
  end
end
