
template "/etc/init.d/skyline-analyzer" do
  source "analyzer.init.erb"
  owner "root"
  group "root"
  mode 00755
end

template "/etc/init.d/skyline-horizon" do
  source "horizon.init.erb"
  owner "root"
  group "root"
  mode 00755
end

template "/etc/init.d/skyline-webapp" do
  source "webapp.init.erb"
  owner "root"
  group "root"
  mode 00755
end

service "skyline-analyzer" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "skyline-horizon" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "skyline-webapp" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
