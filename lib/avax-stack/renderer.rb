# frozen_string_literal: true

require 'openssl'
require 'pathname'
require 'yaml'
require 'base64'
require 'fileutils'

module AVAXStack
  # Renderer is class for rendering Opendax templates.
  class Renderer
    TEMPLATE_PATH = Pathname.new('./templates')

    def render
      @config ||= config
      @name ||= @config['app']['name'].downcase

      Dir.glob("#{TEMPLATE_PATH}/**/*.erb", File::FNM_DOTMATCH).each do |file|
        output_file = template_name(file)
        FileUtils.chmod 0o644, output_file if File.exist?(output_file)
        render_file(file, output_file)
      end
    end

    def render_file(file, out_file)
      puts "Rendering #{out_file}"
      result = ERB.new(File.read(file), trim_mode: '-').result(binding)
      dir = File.dirname(out_file)
      FileUtils.mkdir(dir) unless Dir.exist?(dir)
      File.write(out_file, result)
    end

    def template_name(file)
      path = Pathname.new(file)
      out_path = path.relative_path_from(TEMPLATE_PATH).sub('.erb', '')

      File.join('.', out_path)
    end

    def config
      YAML.load_file('./config/app.yaml')
    end
  end
end
