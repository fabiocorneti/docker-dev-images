require 'rake'
require 'docker'
require 'excon'
require 'rspec/core/rake_task'

if ENV['DOCKER_CERT_PATH']
  Excon.defaults[:ssl_verify_peer] = false
  Excon.defaults[:ssl_verify_callback] = lambda { |verify_ok, store_context|
    if !verify_ok
      failed_cert = store_context.current_cert
      failed_cert_reason = "%d: %s" % [ store_context.error, store_context.error_string ]
      print "WARNING - SSL verification error - Reason: #{failed_cert_reason}\n"
      end
      verify_ok
    }
end

task :spec    => 'spec:all'
task :build   => 'build:all'
task :default => :spec

images = %w(
  centos-dev
  postgresql
)

namespace :build do
  task :all => images
  images.each do |image|
    desc "Build image #{image}"
    docker_image = Docker::Image.build_from_dir(image)
    docker_image.tag('repo' => "corneti/#{image}", 'force' => true)
  end
end

namespace :spec do
  task :all => images
  images.each do |image|
    desc "Run spec for image #{image}"
    RSpec::Core::RakeTask.new(image) do |t|
      t.pattern = "spec/#{image}/*_spec.rb"
    end
  end
end
