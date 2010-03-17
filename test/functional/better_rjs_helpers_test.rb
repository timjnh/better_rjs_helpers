require File.dirname(File.dirname(__FILE__)) + '/test_helper'

class BetterRjsHelpersTest < ActionController::TestCase
  class TestController < ActionController::Base
    def test_action_with_regular_helper_call
      render :update do |page|
        page.replace_html :image, image_tag('foo.png')
      end
    end
    
    def test_action_with_js_helper_call
      render :update do |page|
        page.show :foo
      end
    end
  end
  
  def setup
    super
    @controller = TestController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_action_with_regular_helper_call
    assert_nothing_raised { get :test_action_with_regular_helper_call }
    assert_equal 'Element.update("image", "<img alt=\\"Foo\\" src=\\"/images/foo.png\\" />");', @response.body
  end
  
  def test_action_with_js_helper_call
    assert_nothing_raised { get :test_action_with_js_helper_call }
    assert_equal 'Element.show("foo");', @response.body
  end
end
