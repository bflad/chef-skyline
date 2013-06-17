
redis_server = resources("redis_instance[server]")
redis_server.run_action(:create)

redis_conf = resources("template[#{node['redis']['conf_dir']}/server.conf]")
redis_conf.cookbook = "skyline"
