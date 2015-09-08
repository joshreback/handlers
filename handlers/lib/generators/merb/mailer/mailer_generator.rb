require "rails/generators/erb/mailer/mailer_generator"
require "pry"

module Merb
  module Generators
    class MailerGenerator < Erb::Generators::MailerGenerator
      source_root File.expand_path("../templates", __FILE__)

      def copy_view_files
        view_base_path = File.join("app/views", class_path, file_name + '_mailer')
        empty_directory view_base_path

        actions.each do |action|
          @action = action

          if formats.empty?
            @path = File.join(view_base_path, filename_with_extensions(action, format))
            template filename_with_extensions(:view, format), @path
          else
            formats.each do |format|
              @path = File.join(view_base_path, filename_with_extensions(action, format))
              template filename_with_extensions(:view, format), @path
            end
          end
        end
      end

      protected
      def formats
        [] # Our templates have no format
      end

      def format
        nil
      end

      def handler
        :merb
      end
    end
  end
end
