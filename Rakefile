require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

images = [
    'postgresql'
]

namespace :spec do
  task :all => images
  images.each do |image|
    desc "Run spec for image #{image}"
    RSpec::Core::RakeTask.new(image) do |t|
      t.pattern = "spec/#{image}/*_spec.rb"
    end
  end
end
