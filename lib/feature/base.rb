require 'set'
module Feature
  class Base
    def initialize(features)
      @features = features
      @actions = build_actions_feature_map(features)
      @disabled_features = Set.new
    end

    def [](feature_name)
      @features[feature_name]
    end
    
    def disable(*feature_names)
      feature_names.each do |feature_name|
        raise UnknownFeatureError, "Unknown feature name: #{feature_name}" unless @features.has_key?(feature_name)
        @disabled_features << feature_name
      end
    end

    def disabled_action?(controller, action)
      feature = @actions["#{controller}:#{action}"]
      disabled?(feature)
    end

    def disabled?(feature_name)
      @disabled_features.include? feature_name
    end

    private
    def build_actions_feature_map(features)
      map = {}
      features.each do |feature, controllers|
        controllers.each do |controller_name, actions|
          actions.each do |action_name|
            map["#{controller_name}:#{action_name}"] = feature
          end
        end
      end
      map
    end
  end
end