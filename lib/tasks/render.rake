require_relative '../avax-stack/renderer'

namespace :render do
  desc 'Render configuration and compose files and keys'
  task :config do
    renderer = AVAXStack::Renderer.new
    renderer.render
  end
end
