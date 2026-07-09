#!/usr/bin/env fish

# Install s3fs
#
# Edit fuse config 
# sudo nvim /etc/fuse.conf
# uncomment `user_allow_other`
#
# Create ~/.passwd-s3fs
# authtoken:secret


set bucket $argv[1]
set path $argv[2]
set region "sfo2" #; and set region $argv[3]

set url https://$region.digitaloceanspaces.com

echo bucket: $bucket 
echo path: $path 
echo region: $region
echo url: $url


umount $path
mkdir -p $path
s3fs $bucket $path -o passwd_file=$HOME/.passwd-s3fs -o url=$url -o allow_other

echo "done"
