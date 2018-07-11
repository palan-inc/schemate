require 'active_support/configurable'
module Schemate
  def self.configure(&block)
    yield @config ||= Schemate::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :auto_generate
    config_accessor :auto_generate_type
  end

  configure do |config|
    config.auto_generate = false
    config.auto_generate_type = 'md'
  end
end
