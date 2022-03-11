require_relative '../eth-stack/renderer'

namespace :render do
  desc 'Render configuration and compose files and keys'
  task :config do
    renderer = ETHStack::Renderer.new
    renderer.render
  end
end
