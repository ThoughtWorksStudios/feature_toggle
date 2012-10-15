require 'set'
module FeatureToggle
  class Features
    def initialize(features)
      @features = features
      @actions = build_actions_feature_map(features)
      @deactivated_features = Set.new
    end

    def [](feature_name)
      @features[feature_name]
    end

    def activate(*feature_names)
      feature_names.each do |feature_name|
        @deactivated_features.delete(feature_name) if valid?(feature_name)
      end
    end

    def deactivate(*feature_names)
      feature_names.each do |feature_name|
        @deactivated_features << feature_name if valid?(feature_name)
      end
    end

    def active_action?(controller, action)
      feature = @actions["#{controller}:#{action}"] || @actions["#{controller}:*"]
      active?(feature)
    end

    def active?(feature_name)
      !@deactivated_features.include?(feature_name)
    end

    private

    def valid?(feature_name)
      @features.has_key?(feature_name).tap do |exists|
        puts "Unknown feature: #{feature_name}" unless exists
      end
    end

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
