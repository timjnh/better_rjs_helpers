require File.join(File.dirname(__FILE__), 'lib', 'better_rjs_helpers')
ActionView::Helpers::PrototypeHelper::JavaScriptGenerator.send(:include, BetterRjsHelpers)
