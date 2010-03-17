require File.dirname(File.dirname(__FILE__)) + '/test_helper'

module Unit
  class BetterRjsHelpersTest < Test::Unit::TestCase
    class TestObject     
      def initialize
        @context = Context.new
        @lines = ['bleh;']
        include_helpers_from_context
      end
      
      def include_helpers_from_context; end
      
      # the following methods save us from infinite loops during the tests
      def <<(*args); end
      def arguments_for_call(*args); end
    end
    TestObject.send(:include, BetterRjsHelpers)
    
    class Context
      def hello_world; 'hello world!'; end
    end
    
    def test_with_context_method
      assert_equal 'hello world!', TestObject.new.hello_world
    end
    
    def test_with_non_context_method
      assert TestObject.new.foo_bar.is_a?(ActionView::Helpers::JavaScriptProxy)
    end
  end
end #Unit
