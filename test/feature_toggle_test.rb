require "test/unit"

require "feature_toggle"

class FeatureToggleTest < Test::Unit::TestCase
  def test_load_features
    features = load_features
    assert_equal({'users' => ['update', 'show']}, features['user_profile'])
  end

  def test_can_deactivate_features
    features = load_features
    assert features.active?('user_profile')

    features.deactivate("user_profile")
    assert !features.active?('user_profile')

    features.deactivate("wpc", "rao")
    assert !features.active?('wpc')
    assert !features.active?('rao')
  end

  def test_disabling_non_existent_features_should_raise_error
    features = load_features
    assert_raises FeatureToggle::UnknownFeatureError do
      features.deactivate("user")
    end
  end

  def test_feature_actions_should_be_active_when_feature_is_active
    features = load_features
    assert features.active_action?('users', 'update')
    features.deactivate("user_profile")
    assert !features.active_action?('users', 'update')
  end

  def test_feature_action_should_be_active_when_no_feature_defines_the_action
    features = load_features
    assert features.active_action?('users', 'destroy')
  end

  def load_features
    config = File.join(File.dirname(__FILE__), 'features.yml')
    FeatureToggle.load(config)
  end
end