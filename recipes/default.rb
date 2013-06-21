
include_recipe "skyline::redis"
include_recipe "scipy"

node['skyline']['packages'].each do |p|
  package p
end

node['skyline']['pip_packages'].each do |pp|
  python_pip pp
end

user node['skyline']['user'] do
  comment "Skyline Service Account"
  supports :manage_home => true
  system  true
  action  :create 
end

directory node['skyline']['log_path'] do
  owner node['skyline']['user']
  group node['skyline']['group']
  mode 00755
  action :create
end

directory node['skyline']['pid_path'] do
  owner node['skyline']['user']
  group node['skyline']['group']
  mode 00755
  action :create
end

include_recipe "skyline::source"
include_recipe "skyline::init"
