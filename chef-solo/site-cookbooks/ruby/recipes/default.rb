#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "/home/#{node[:operator]}/.rbenv" do
  repository 'git://github.com/sstephenson/rbenv.git'
  user  node[:operator]
  group node[:operator_group]
end

directory "/home/#{node[:operator]}/.rbenv/plugins" do
  owner node[:operator]
  group node[:operator_group]
  mode  "0775"
  action :create
end

bash "add_rbenv_init" do
   user  node[:operator]
   group node[:operator_group]
   environment "HOME" => "/home/#{node[:operator]}"
   cwd "/home/#{node[:operator]}"
   code <<-EOH
     echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/#{node[:operator]}/.bashrc
     echo 'eval "$(rbenv init -)"' >> /home/#{node[:operator]}/.bashrc
   EOH
end

git "/home/#{node[:operator]}/.rbenv/plugins/ruby-build" do
  repository 'git://github.com/sstephenson/ruby-build.git'
  user  node[:operator]
  group node[:operator_group]
end

bash "install_ruby" do
   user node[:operator]
   group node[:operator_group]
   environment "HOME" => "/home/#{node[:operator]}"
   cwd "/home/#{node[:operator]}"
   code <<-EOH
     source /home/#{node[:operator]}/.bashrc
     install_version="#{node[:ruby_version]}"
     rbenv install $install_version
     rbenv global $install_version
   EOH
end

# install gems
gem_package 'bundler' do
  gem_binary("/home/#{node[:operator]}/.rbenv/shims/gem")
  action :install
  version node[:bundle_version]
end
