require 'yaml'
require 'feature_toggle/features'
module FeatureToggle
  class UnknownFeatureError < StandardError
  end

  def load(config_file)
    Features.new YAML.load(File.read(config_file))
  end
  module_function :load
end
