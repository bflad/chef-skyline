# chef-skyline [![Build Status](https://secure.travis-ci.org/bflad/chef-skyline.png?branch=master)](http://travis-ci.org/bflad/chef-skyline)

## Description

Installs/configures [Skyline](https://github.com/etsy/skyline).

## Requirements

### Platforms

* CentOS 6
* Fedora 17, 18, 19
* Red Hat Enterprise Linux 6
* Ubuntu 12.04, 12.10, 13.04

### Cookbooks

[Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [git](https://github.com/opscode-cookbooks/git)
* [python](https://github.com/opscode-cookbooks/python)

Third-Party Cookbooks

* [redis](https://github.com/miah/chef-redis)
* [scipy](https://github.com/bflad/chef-scipy)

## Attributes

These attributes are under the `node['skyline']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
full_duration | See templates/default/settings.py.erb | Fixnum | 86400
full_namespace | See templates/default/settings.py.erb | String | "metrics."
graphite_host | See templates/default/settings.py.erb | String | http://graphite.example.com
group | Skyline group | String | `node['skyline']['user']`
log_path | See templates/default/settings.py.erb | String | /var/log/skyline
mini_duration | See templates/default/settings.py.erb | Fixnum | 3600
mini_namespace | See templates/default/settings.py.erb | String | "mini."
oculus_host | See templates/default/settings.py.erb | String | http://oculus.example.com
pid_path | See templates/default/settings.py.erb | String | /var/run/skyline
pip_packages | PIP packages for installation | Array of Strings | See attributes/default.rb
redis_socket_path | See templates/default/settings.py.erb | String | /tmp/redis.sock
user | Skyline user | String | skyline

### Analyzer Attributes

These attributes are under the `node['skyline']['analyzer']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
algorithms | See templates/default/settings.py.erb | Array of Strings | See attributes/default.rb
analyzer_processes | See templates/default/settings.py.erb | Fixnum | 5
anomaly_dump | See templates/default/settings.py.erb | String | webapp/static/dump/anomalies.json
canary_metric | See templates/default/settings.py.erb | String | statsd.numStats
consensus | See templates/default/settings.py.erb | Fixnum | 5
min_tolerable_length | See templates/default/settings.py.erb | Fixnum | 1
max_tolerable_boredom | See templates/default/settings.py.erb | Fixnum | 100
stale_period | See templates/default/settings.py.erb | Fixnum | 500

### Horizon Attributes

These attributes are under the `node['skyline']['horizon']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
chunk_size | See templates/default/settings.py.erb | Fixnum | 10
horizon_ip | See templates/default/settings.py.erb | String | nil
max_queue_size | See templates/default/settings.py.erb | Fixnum | 500
max_resolution | See templates/default/settings.py.erb | Fixnum | 1000
pickle_port | See templates/default/settings.py.erb | Fixnum | 2024
roomba_processes | See templates/default/settings.py.erb | Fixnum | 1
skip_list | See templates/default/settings.py.erb | Array of Strings | []
udp_port | See templates/default/settings.py.erb | Fixnum | 2025
worker_processes | See templates/default/settings.py.erb | Fixnum | 2

### Webapp Attributes

These attributes are under the `node['skyline']['webapp']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
webapp_ip | See templates/default/settings.py.erb | String | 127.0.0.1
webapp_port | See templates/default/settings.py.erb | Fixnum | 1500

## Recipes

* `recipe[skyline]` default installation/configuration of Skyline
* `recipe[skyline::init]` symlinks Skyline init scripts and starts/enables services
* `recipe[skyline::redis]` configures Redis for Skyline from template
* `recipe[skyline::source]` installs Skyline via source

## Usage

### Skyline Installation

* Add `recipe[skyline]` to your node's run list.

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    git clone git://github.com/bflad/chef-skyline.git
    cd chef-skyline
    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-omnibus
    vagrant up BOX # BOX being centos6, ubuntu1204, ubuntu1210, or ubuntu1304

You can then SSH into the running VM using the `vagrant ssh` command.
The VM can easily be stopped and deleted with the `vagrant destroy`
command. Please see the official [Vagrant documentation](http://vagrantup.com/v1/docs/commands.html)
for a more in depth explanation of available commands.

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Authors

See [LICENSE](LICENSE) file for more information.

* Author:: Brian Flad (<bflad417@gmail.com>)
* Copyright:: 2013 Brian Flad
