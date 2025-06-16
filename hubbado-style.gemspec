Gem::Specification.new do |s|
  s.name = "hubbado-style"
  s.version = "1.5.2"
  s.summary = "Hubbado style guides and shared style configs."

  s.authors = ["Hubbado Devs"]
  s.email = ["devs@hubbado.com"]
  s.homepage = "https://github.com/hubbado/hubbado-style"
  s.license  = "MIT"

  s.require_paths = ["lib"]

  s.files = Dir.glob(%w[
    default.yml
    *.gemspec
    LICENSE*
    README*
    CHANGELOG*
  ])

  s.add_dependency "rubocop"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
end
