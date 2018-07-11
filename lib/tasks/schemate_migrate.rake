require "schemate/config"

namespace :db do
  [:migrate, :rollback].each do |cmd|
    task cmd do
      if Schemate.config.auto_generate_type == 'md'
        Rake::Task['schemate:export_md'].invoke if Schemate.config.auto_generate
      elsif Schemate.config.auto_generate_type == 'csv'
        Rake::Task['schemate:export_csv'].invoke if Schemate.config.auto_generate
      end
    end

    namespace cmd do
      [:change, :up, :down, :reset, :redo].each do |t|
        task t do
          if Schemate.config.auto_generate_type == 'md'
            Rake::Task['schemate:export_md'].invoke if Schemate.config.auto_generate
          elsif Schemate.config.auto_generate_type == 'csv'
            Rake::Task['schemate:export_csv'].invoke if Schemate.config.auto_generate
          end
        end
      end
    end
  end
end
