Gem::Specification.new do |spec|
  spec.name          = 'lita-github-status'
  spec.version       = '0.1.0'
  spec.authors       = ['Mike Fiedler']
  spec.email         = ['miketheman@gmail.com']
  spec.description   = 'Ask your bot how GitHub is doing'
  spec.summary       = 'Lita Handler to query GitHub status API'
  spec.homepage      = 'https://github.com/miketheman/lita-github-status'
  spec.license       = 'WTFPL'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
