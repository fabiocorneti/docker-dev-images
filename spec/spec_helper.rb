#NOTE: includes circleci workarounds from https://github.com/avatarnewyork/dockerenv_apache/blob/master/spec/localhost/Dockerfile_spec.rb
# and http://www.slideshare.net/minimum2scp/circle-ci-and-dockerserverspec

require 'serverspec'
require 'docker'

# Workaround needed for circleCI
if ENV['CIRCLECI']
  class Docker::Container
    def remove(options={}); end
    alias_method :delete, :remove
  end
end
