site :opscode

metadata

cookbook "redis", github: "miah/chef-redis"
cookbook "scipy", github: "bflad/chef-scipy"

group :integration do
  cookbook "minitest-handler"
  cookbook "skyline_test", :path => "test/cookbooks/skyline_test"
end
