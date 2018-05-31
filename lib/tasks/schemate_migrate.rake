namespace :db do
  [:migrate, :rollback].each do |cmd|
    task cmd do
      Rake::Task['schemate:export_md'].invoke
    end

    namespace cmd do
      [:change, :up, :down, :reset, :redo].each do |t|
        task t do
          Rake::Task['schemate:export_md'].invoke
        end
      end
    end
  end
end
