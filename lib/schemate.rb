require "schemate/version"

module Schemate
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/export_schema.rake"
      load "tasks/schemate_migrate.rake"
    end
  end
end
