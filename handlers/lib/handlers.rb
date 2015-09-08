require 'action_view/template'
require 'rdiscount'
require 'pry'

module Handlers
  module Merb
    def self.erb_handler
      @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def self.call(template)
      compiled_source = erb_handler.call(template)
      if template.formats.include?(:html)
        "RDiscount.new(begin;#{compiled_source};end).to_html"
      else
        compiled_source
      end
    end
  end
end

ActionView::Template.register_template_handler :rb, :source.to_proc
ActionView::Template.register_template_handler :string,
  lambda { |template| "%Q{#{template.source}}" }
ActionView::Template.register_template_handler :md,
  lambda { |template| "RDiscount.new(#{template.source.inspect}).to_html" }
ActionView::Template.register_template_handler :merb, Handlers::Merb
