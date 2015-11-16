#
# Cookbook Name:: fog
# Recipe:: default
#
# Copyright 2014, RightScale Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential::default"
include_recipe "libxml2::default"

if node['platform_family'] == "debian"
  p= package "zlib1g-dev" do
    action :nothing
  end
  p.run_action(:install)
end

chef_gem "fog" do
  compile_time true if respond_to?(:compile_time)
  version node['fog']['version']
  action :install
end

Gem.clear_paths
