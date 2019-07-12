#!/bin/bash
# get base dir regardless of execution location
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
. $(dirname $SOURCE)/init.sh

minecraftversion=$(cat $basedir/Paper/work/BuildData/info.json | grep minecraftVersion | cut -d '"' -f 4)

basedir
pushRepo PaperDragon-API ${API_REPO} master:${minecraftversion}
pushRepo PaperDragon-Server ${SERVER_REPO} master:${minecraftversion}
pushRepo mc-dev ${MCDEV_REPO} ${paperVer}

# Push Parent to Three Remotes
git push origin master -f
git push pd-push master -f
