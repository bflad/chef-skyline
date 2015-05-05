
include_recipe 'git'

git node['skyline']['install_dir'] do
  repository node['skyline']['source']['repo']
  reference node['skyline']['source']['reference']
  action :sync
end

execute 'reset-to-commit-version' do
  command "git reset --hard #{node['skyline']['source']['commit_hash']}"
  cwd node['skyline']['install_dir']
  action :run
end

template "#{node['skyline']['install_dir']}/src/settings.py" do
  source 'settings.py.erb'
  owner 'root'
  group 'root'
  mode 00644
end

directory "#{node['skyline']['install_dir']}/src/webapp/static/dump" do
  owner node['skyline']['user']
  group node['skyline']['group']
  mode 00755
  recursive true
  action :create
end
