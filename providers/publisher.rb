####################################################################
# COOKBOOK NAME: openindiana
# RECIPE: publisher
# DESCRIPTION: publisher LWRP for managing OI package publishers
#
####################################################################
# (C)2011 DigiTar, All Rights Reserved
# Distributed under the BSD License
# 
# Redistribution and use in source and binary forms, with or without modification, 
#    are permitted provided that the following conditions are met:
#
#        * Redistributions of source code must retain the above copyright notice, 
#          this list of conditions and the following disclaimer.
#        * Redistributions in binary form must reproduce the above copyright notice, 
#          this list of conditions and the following disclaimer in the documentation 
#          and/or other materials provided with the distribution.
#        * Neither the name of DigiTar nor the names of its contributors may be
#          used to endorse or promote products derived from this software without 
#          specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
# SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
# DAMAGE.
#
####################################################################

action :set do  
  if new_resource.preferred
    preferred = "-P"
  else
    preferred = ""
  end
  
  execute "set publisher #{new_resource.name}" do
    action :run
    command "pkg set-publisher #{preferred} -g '#{new_resource.url}' '#{new_resource.name}'"
  end
end

action :add_origin do
  if new_resource.preferred
    preferred = "-P"
  else
    preferred = ""
  end
  
  execute "add origin #{new_resource.url} to #{new_resource.name}" do
    action :run
    command "pkg set-publisher #{preferred} -g '#{new_resource.url}' '#{new_resource.name}'"
  end
end

action :remove_origin do
  execute "remove origin #{new_resource.url} from #{new_resource.name}" do
    action :run
    command "pkg set-publisher -G '#{new_resource.url}' '#{new_resource.name}'"
  end
end

action :add_mirror do
  execute "add mirror #{new_resource.url} to #{new_resource.name}" do
    action :run
    command "pkg set-publisher -m '#{new_resource.url}' '#{new_resource.name}'"
  end
end

action :remove_mirror do
  execute "remove mirror #{new_resource.url} from #{new_resource.name}" do
    action :run
    command "pkg set-publisher -M '#{new_resource.url}' '#{new_resource.name}'"
  end
end

action :unset do
  execute "unset publisher #{new_resource.name}" do
    action :run
    command "pkg unset-publisher '#{new_resource.name}'"
  end
end

action :refresh do
  execute "refresh publisher metadata" do
    action :run
    command "pkg refresh '#{new_resource.name}'"
  end
end
