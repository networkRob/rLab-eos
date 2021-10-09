#!/bin/bash

while getopts t:s: option
do
case "${option}"
in
t) TOPO=${OPTARG};;
s) FLAG=true;;
esac
done

YELLOW='\033[1;33m'
NC='\033[0m'

#topobuilder
echo -e "${YELLOW}Building topo: $TOPO${NC}\n"
if [[ $FLAG == true ]];
then
  build/topo-builder.py -t $TOPO -s
else
  build/topo-builder.py -t $TOPO 
fi


echo -e "${YELLOW}DONE: Building topo: $TOPO${NC}\n"

echo ""
echo -e "${YELLOW}Building diagram for topo: $TOPO${NC}\n"
#yamlviz
build/yamlviz.py -t $TOPO
echo -e "${YELLOW}DONE: Building diagram for topo: $TOPO${NC}\n"

# don't forget to update the README
# don't forget to update requirements.txt