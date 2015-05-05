name 'skyline'
maintainer 'Brian Flad'
maintainer_email 'bflad417@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures Skyline'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.1'
recipe 'skyline', 'Installs/Configures Skyline'
recipe 'skyline::init', 'Symlinks Skyline init scripts and starts/enables services'
recipe 'skyline::redis', 'Configures Redis for Skyline from template'
recipe 'skyline::source', 'Installs Skyline via source'

%w(amazon centos debian fedora redhat scientific ubuntu).each do |os|
  supports os
end

%w(git python redis scipy).each do |cb|
  depends cb
end
