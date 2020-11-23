#!/bin/bash
NAME=$(jq -r .name package.json)
echo "$NAME"
echo "Reading environmental variables from ${NAME}-srv"
echo "Creating/Updating default-env.json"
cf env capmt-srv | sed '1,4d' | sed -n '/VCAP_APPLICATION/q;p' | sed '$d' | tee default-env.json
echo "Copying default-env.json to db and app folder"
cp ./default-env.json ./db/default-env.json
cp ./default-env.json ./srv/default-env.json
cp ./default-env.json ./app/default-env.json
echo "Add destinations from destination.txt to approuter"
gsed -i -e '2 { r ./app/destination.txt' -e 'N; }' ./app/default-env.json
echo "done"

