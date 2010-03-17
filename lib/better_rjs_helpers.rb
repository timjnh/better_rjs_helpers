module BetterRjsHelpers
  def self.included(base)
    base.class_eval do
      alias_method_chain :include_helpers_from_context, :route_to_context
    end
  end
  
  # Wrapper for the include_helpers_from_context method in JavascriptGenerator
  # Normally it includes GeneratorMethods which has a method_missing definition
  # that routes all unhandled methods to a JavascriptProxy instance.  We add
  # our own definition that routes to @context if @context knows about the
  # method.  If not then we go to the original behavior.
  def include_helpers_from_context_with_route_to_context
    include_helpers_from_context_without_route_to_context
    extend RouteToContext
  end
  
  # Houses our method_missing implementation.  Checks if @context responds to
  # the missing method and, if so, routes us there instead.  Otherwise we fall
  # back on the JavascriptProxy.  We could have been nicer here an not nuked the
  # entire method_missing implementation but as it does so little...
  module RouteToContext
    def method_missing(method, *args, &block)
      if @context.respond_to?(method)
        @context.send(method, *args, &block)
      else
        ActionView::Helpers::JavaScriptProxy.new(self, method.to_s.camelize)
      end
    end
  end #RouteToContext
end #BetterRjsHelpers
