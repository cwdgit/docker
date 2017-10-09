#!/bin/bash
#输入cookbook的名称
echo "arg1" $1
echo "arg2" $2
echo "arg3" $3
#echo "arg4" $4
#判断cookbook是否存在
cookname=$1
hostname=$2
tagversion=$3
tagport=$4

cd /opt/chef-repo/cookbooks/
if [ -e $cookname ];then
  echo -e "\033[31;49;1mThe cookbook is exist, you can't use the cookname.if you want to build new cookbook,please logout\033[31;49;0m"
        exit 7
fi

#创建cookbook
cd /opt/chef-repo
knife cookbook create $cookname &> /dev/null
#修改metadata.rb文件
echo "depends 'docker', '~> 2.0'" >> cookbooks/$cookname/metadata.rb
#修改recipes文件
dockername="registry.com/library/$cookname"
cd /opt/chef-repo/cookbooks/$cookname/recipes/

echo "docker_image '$dockername' do 

 tag '$tagversion'

 action :pull

 notifies :redeploy, 'docker_container["$cookname"_container]'

end " > default.rb

echo " 

  docker_container '"$cookname"_container' do

  repo '$dockername'

  tag '$tagversion'

  port '80:8080'

  domain_name '$hostname'

 end " >> default.rb

cd /opt/chef-repo
knife cookbook upload $cookname

