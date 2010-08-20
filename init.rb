# Include hook code here
require 'html5'

ActionView::Base.send :include, ActionView::Helpers::Html5FormTagHelper
ActionView::Base.send :include, ActionView::Helpers::Html5FormHelper