require "rails/generators/erb/mailer/mailer_generator"
require "pry"

module Merb
  module Generators
    class MailerGenerator < Erb::Generators::MailerGenerator
      source_root File.expand_path("../templates", __FILE__)
      binding.pry

      protected
      def format
        binding.pry
        nil # Our templates have no format
      end

      def handler
        :merb
      end
    end
  end
end
