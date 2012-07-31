
# FeatureToggle

FeatureToggle is a [feature toggle](http://martinfowler.com/bliki/FeatureToggle.html) library for ruby.

## Installation

        gem install feature_toggle

## Examples

### Rails

        # File: Gemfile
        gem 'feature_toggle'

        # File: config/features.yml
        feature1:
            controller1:
				- action1
				- action2
			controller2:
				- action1
				- action2
        feature2:
			controller3:
				- action1
				- action2
        feature3:
            controller4:
				- action1
				- action2

        # File: config/initializers/feature_toggle.rb
		FEATURES = FeatureToggle.load(File.join(RAILS_ROOT, 'config', 'features.yml'))
		FEATURES.deactivate('feature1', 'feature2', 'feature3')

        # File: app/controllers/application_controller.rb
		before_filter :check_feature_activated?

		def	check_feature_activated?
			FEATURES.active_action?(params[:controller], params[:action])
		end

        # File: app/views/example/index.html.erb
        <% if FEATURES.active?('feature1') %>
          <%# Feature implementation goes here %>
        <% end %>
        <% if FEATURES.active_action?('controller4', 'action1') %>
          <%# Feature implementation goes here %>
        <% end %>

