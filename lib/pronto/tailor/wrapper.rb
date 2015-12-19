require 'open3'
require_relative 'configuration'

module Pronto
  module Tailor
    class Wrapper
      attr_reader :patch
      def initialize(patch)
        @patch = patch
      end

      def lint
        return [] if patch.nil?
        configuration = Configuration.new(ENV)
        path = patch.new_file_full_path.to_s
        stdout, stderr, _status = Open3.capture3(configuration.command_line_for_file(path))
        puts "WARN: pronto-tailor: #{stderr}" if stderr && stderr.size > 0
        return [] if stdout.nil? || stdout.size == 0
        parse_output_in_file(path, stdout)
      rescue => e
        puts "ERROR: pronto-tailor failed to process a diff: #{e}"
        []
      end

      private

      def parse_output_in_file(path, output)
        output.lines.map do |line|
          next unless line.start_with?(path)
          line_parts = line.split(':')
          offence_in_line = line_parts[1]
          if line_parts[2].to_i == 0
            offence_level = line_parts[2].strip
          else
            offence_level = line_parts[3].strip
          end
          offence_rule = line[/\[.*?\]/].gsub('[', '').gsub(']', '')
          index_of_offence_rule = line.index(offence_rule)
          offence_message = line[index_of_offence_rule + offence_rule.size + 2..line.size]
          {
            'line' => offence_in_line.to_i,
            'level' => offence_level,
            'rule' => offence_rule,
            'message' => offence_message
          }
        end.compact
      end
    end
  end
end
