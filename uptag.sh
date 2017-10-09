echo "arg1"$1
echo "arg2"$2
VERSION=$1
TVERSION="tag '$VERSION'"
COOKBOOK=$2
cd /opt/chef-repo/cookbooks/$COOKBOOK/recipes/
sed -i "s/tag[[:space:]].*/$TVERSION/g" default.rb
knife cookbook upload $COOKBOOK
sleep 3
