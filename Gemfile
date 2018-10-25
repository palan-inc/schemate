source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

group :development, :test do
  gem 'byebug'
  gem 'guard-rspec', require: false
  gem 'rspec', require: false

  gem "rubocop", ">= 0.49.0"
  gem 'simplecov', require: false

  gem 'codeclimate-test-reporter'
  gem 'coveralls'

  platforms :mri, :mingw do
    gem 'pry', require: false
    gem 'pry-coolline', require: false
  end
end

# Specify your gem's dependencies in schemate.gemspec
gemspec
