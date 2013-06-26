
case node['platform_family']
when "debian"
  default['skyline']['packages'] = %w{
    netcat
  }
when "rhel"
  default['skyline']['packages'] = %w{
    nc
  }
else
  default['skyline']['packages'] = %w{}
end

default['skyline']['pip_packages'] = %w{
  redis
  hiredis
  python-daemon
  flask
  simplejson
  unittest2
  mock
  patsy
  statsmodels
  msgpack-python
}

default['skyline']['user'] = "skyline"
default['skyline']['group'] = node['skyline']['user']

# Shared Settings

default['skyline']['full_duration'] = 86400
default['skyline']['full_namespace'] = "metrics."
default['skyline']['graphite_host'] = "http://graphite.example.com"
default['skyline']['install_dir'] = "/opt/skyline"
default['skyline']['log_path'] = "/var/log/skyline"
default['skyline']['mini_duration'] = 3600
default['skyline']['mini_namespace'] = "mini."
default['skyline']['oculus_host'] = "http://oculus.example.com"
default['skyline']['pid_path'] = "/var/run/skyline"
default['skyline']['redis_socket_path'] = node['redis']['config']['unixsocket']

# Analyzer Settings

default['skyline']['analyzer']['algorithms'] = %w{
  first_hour_average
  mean_subtraction_cumulation
  simple_stddev_from_moving_average
  stddev_from_moving_average
  least_squares
  grubbs
  histogram_bins
}
default['skyline']['analyzer']['analyzer_processes'] = 5
default['skyline']['analyzer']['anomaly_dump'] = "webapp/static/dump/anomalies.json"
default['skyline']['analyzer']['canary_metric'] = "statsd.numStats"
default['skyline']['analyzer']['consensus'] = 5
default['skyline']['analyzer']['min_tolerable_length'] = 1
default['skyline']['analyzer']['max_tolerable_boredom'] = 100
default['skyline']['analyzer']['stale_period'] = 500

# Horizon Settings

default['skyline']['horizon']['chunk_size'] = 10
default['skyline']['horizon']['horizon_ip'] = nil
default['skyline']['horizon']['max_queue_size'] = 500
default['skyline']['horizon']['max_resolution'] = 1000
default['skyline']['horizon']['pickle_port'] = 2024
default['skyline']['horizon']['roomba_processes'] = 1
default['skyline']['horizon']['skip_list'] = []
default['skyline']['horizon']['udp_port'] = 2025
default['skyline']['horizon']['worker_processes'] = 2

# Source Settings

default['skyline']['source']['repo'] = 'git://github.com/etsy/skyline.git'
default['skyline']['source']['reference'] = "master"

# Webapp Settings

default['skyline']['webapp']['webapp_ip'] = "127.0.0.1"
default['skyline']['webapp']['webapp_port'] = 1500
