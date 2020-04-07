#!/bin/bash -ex
# This script remove all containers logs in Linux systems running docker
# Use parammeter -y to auto confirm

confirm=${1:null}
containers_names=$(docker ps  --format "{{.Names}}")
logs=$(docker inspect -f '{{.LogPath}}' $containers_names 2> /dev/null)

echo ""
echo "This containers will get their logs clean:"
echo $containers_names
echo ""
echo "These are the logs files to delete:"
echo "$(echo $logs | sudo xargs -n 1 du -ah)"
echo ""

if [[ $confirm == '-y' ]]; then
	input='yes'
else 
	echo "Are you sure? Type yes to proceed."
	read input
fi

if [[ $input == 'yes' ]]; then
	truncate -s 0 $logs
	echo "Done"
fi
