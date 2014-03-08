#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{mysql mysql-devel}.each do |package_name|
  package package_name do
    action :install
  end
end

package "mysql-server" do
  action :install
end

execute "mysql-install-db" do
  command "mysql_install_db"
  action  :run
  not_if  { File.exists?('/var/lib/mysql/mysql/user.frm') }
end

service "mysqld" do
  supports status: true, restart: true, reload: true
  action   [ :enable, :start ]
end
