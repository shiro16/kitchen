#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:packages].each do |package_name|
  package package_name do
    action [:install, :upgrade]
  end
end

