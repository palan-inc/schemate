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
  end

  configure do |config|
    config.auto_generate = "false"
  end
end
