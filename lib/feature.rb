require 'yaml'
require 'feature/base'
module Feature
  class UnknownFeatureError < StandardError
  end

  def load(config_file)
    Base.new YAML.load(File.read(config_file))
  end
  module_function :load
end
