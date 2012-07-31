require "test/unit"

require "feature"

class FeatureTest < Test::Unit::TestCase
  def test_load_features
    features = load_features
    assert_equal({'users' => ['update', 'show']}, features['user_profile'])
  end

  def test_can_disable_features
    features = load_features
    assert !features.disabled?('user_profile')

    features.disable("user_profile")
    assert features.disabled?('user_profile')

    features.disable("wpc", "rao")
    assert features.disabled?('wpc')
    assert features.disabled?('rao')
  end

  def test_disabling_non_existent_features_should_raise_error
    features = load_features
    assert_raises Feature::UnknownFeatureError do
      features.disable("user")
    end
  end

  def test_feature_actions_should_be_disabled_when_feature_is_disabled
    features = load_features
    assert !features.disabled_action?('users', 'update')
    features.disable("user_profile")
    assert features.disabled_action?('users', 'update')
  end

  def test_feature_action_should_not_be_disabled_when_no_feature_defines_the_action
    features = load_features
    assert !features.disabled_action?('users', 'destroy')
  end

  def load_features
    config = File.join(File.dirname(__FILE__), 'features.yml')
    Feature.load(config)
  end
end