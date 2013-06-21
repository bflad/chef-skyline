#
# Commented config settings are those missing from redis cookbook.
# Unfortunately, the unixsocket config is required, so all this manual work
# needs to be done below rather than using redis::server redis_instance. :(
#

node.set['redis']['config']['activerehashing'] = true
node.set['redis']['config']['appendfsync'] = "no"
#node.set['redis']['config']['auto_aof_rewrite_min_size'] = "64mb"
#node.set['redis']['config']['auto_aof_rewrite_percentage'] = 100
#node.set['redis']['config']['client_output_buffer_limit'] = [
#  'normal 0 0 0',
#  'slave 0 0 0',
#  'pubsub 32mb 8mb 60'
#]
node.set['redis']['config']['configure_no_appendfsync_on_rewrite'] = true
node.set['redis']['config']['configure_slowlog'] = true
#node.set['redis']['config']['lua_time_limit'] = 5000
node.set['redis']['config']['no_appendfsync_on_rewrite'] = true
node.set['redis']['config']['slowlog_max_len'] = 128
node.set['redis']['config']['timeout'] = 0
#node.set['redis']['config']['unixsocket'] = "/tmp/redis.sock"
#node.set['redis']['config']['unixsocketperms'] = 777

case node['platform_family']
when "debian"
  if node['platform'] == "debian"
    node.set['redis']['install_type'] = "source"
  elsif node['platform_version'].to_i <= 12
    node.set['redis']['install_type'] = "source"
  end
when "fedora"
  node.set['redis']['install_type'] = "source" if node['platform_version'].to_i <= 16 
when "rhel"
  if node['platform'] == "amazon"
    node.set['redis']['install_type'] = "source"
  elsif node['platform_version'].to_i <= 6
    node.set['redis']['install_type'] = "source"
  end
end

include_recipe "redis::install"

if node['redis']['install_type'] == "source"
  node.set['redis']['config']['logfile'] = "/var/log/redis/redis.log" if node['redis']['config']['logfile'] == "stdout"
  directory ::File.dirname(node['redis']['config']['logfile']) do
    owner node['redis']['user']
    group node['redis']['group']
    mode 00755
  end

  directory node['redis']['conf_dir'] do
    owner "root"
    group "root"
    mode 00755
  end

  directory node['redis']['config']['dir'] do
    owner node['redis']['user']
    group node['redis']['group']
    mode 00755
  end

  directory ::File.dirname(node['redis']['config']['pidfile']) do
    owner node['redis']['user']
    group node['redis']['group']
    mode 00755
  end

  template "/etc/init.d/redis-server" do
    source "redis_init.erb"
    cookbook "redis"
    owner "root"
    group "root"
    mode 00755
    variables(
      :conf_dir => node['redis']['conf_dir'],
      :logfile => node['redis']['config']['logfile'],
      :name => "redis",
      :pidfile => node['redis']['config']['pidfile'],
      :port => node['redis']['config']['port'],
      :user => node['redis']['user']
    )
    notifies :restart, "service[redis-server]"
  end
end

template "#{node['redis']['conf_dir']}/redis.conf" do
  source "redis-server.conf.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[redis-server]"
end

service "redis-server" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

