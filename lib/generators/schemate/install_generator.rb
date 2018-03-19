require 'securerandom'

module Schemate
  module Generators
    class InstallGenerator < Rails::Generators::Base


      desc 'Copy annotate_models rakefiles for automatic annotation'
      source_root File.expand_path('templates', __dir__)

      # copy rake tasks
      def copy_tasks
        template 'schemate.rb', 'config/initializers/schemate.rb'
      end

    end
  end
end