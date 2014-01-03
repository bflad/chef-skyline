site :opscode

metadata

cookbook "redis", github: "miah/chef-redis"

group :integration do
  cookbook "minitest-handler"
  cookbook "skyline_test", :path => "test/cookbooks/skyline_test"
end
