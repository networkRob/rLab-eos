## rLab EOS Topologies

This repo will contain the data models and configs to build different toplogies to run EOS as a container.

### Getting Started
To build a new topology, the following files/data structures need to be created.
- `topologies/{name}.yaml` - This file is leveraged by `build/topo-builder.py` to create the necessary commands to build the topology.
- `configs/{topo}/{device}` - This directory structure is were any files you want to be loaded into cEOS-lab's `/mnt/flash` should be loaded to.  Scripts, startup-config etc.

The Following Python package libraries need to be loaded on the machine that will run `topo-builder.py`:
- ruamel.yaml

To run the network topology on a container host machine, you can leverage the following cEOS_host_build Ansible-Playbook to build the environment.  This will install all necessary software to run cEOS-lab. It is located in the following repo:

https://github.com/networkRob/rLab-ansibleBuilds

#### NOTE:
To be able to run MLAG and dot1q, a special build is required for cEOS-Lab that will be availbe in upcoming releases of cEOS-Lab.

#### Topology File Format
There are some required fields to be specified in the topology files.  See the examples listed in the `topologies/` directory.  The required parameters are:
```
topology:
  name: {TOPO_NAME}
images:
  ceos: {ceosimage_tag}
  host: {chostimage_tag}
nodes:
  spine1:
    mac: 00:1c:73:c0:c6:01
    links:
      - leaf11
      - leaf12
hosts:
  host11:
    ipaddress: 192.168.12.11
    mask: 24
    gateway: 192.168.12.1
    links:
      - leaf11
iperf:
  port: 5010
  brate: 1000000
  servers:
    - host11
  clients:
    - client: host21
      target: host11
commands:
```

- The `mac` section for each cEOS-lab node needs to be unique, this helps specify the correct system-id in cEOS so MLAG will function properly.  
- The `links` section for eachc cEOS-lab node is an ordered list for the neighbor device.  Item #1 would referr to `Eth1` on that particular node.
- If you do not want to run iperf on the host nodes, you can leave that section empty and only set `iperf:`
- The `commands:` section can create additional bash scripts to load new configurations on the nodes.  The `topologies/ratd.yaml` file has examples for this.

## Creating a Topology

Clone this repo to your container host node and enter the main directory for this repo.  

Here are the steps required to get it running for the first time.

1. Import a cEOS-lab container archive:
```
docker import  --change 'VOLUME /mnt/flash/' cEOS-lab.tar.xz ceosimage:{ceosimage_tag}
```
{ceosimage_tag} = tag for the image, ie `4.22.1F.Trunk`

2. Build and tag the host node:
```
docker build -t chost:{chostimage_tag} build/hosts/.
```
{chostimage_tag} = tag for the image, ie `0.5`

3. Create the topology scripts:
```
build/topo-builder.py -t {topo}
```
{topo} is the filename for the topology file located in `topologies/` without the `.yaml` extension. For the L2 topology, the command would look like:
```
build/topo-builder.py -t l2
```

4. The `topo-builder.py` script will create a minimum of 4 bash scripts.  They are located in `cnt/{TOPO_NAME}/`.  It is important to run the commands for the project directories top-level directory.  
The four main scripts created are as follows with their description:
- `Create.sh` - Creates all Open vSwitch bridges, containers, starts containers and links all containers together.
- `Start.sh` - Starts all stopped containers and links all containers together.
- `Stop.sh` - Disconnects all links between containers and stops running containers.
- `Destroy.sh` - Disconnects all links between containeres, stops running containers, removes containers, and removes Open vSwitch bridges.

An example on creating and starting a new topology, use the following command:
```
bash cnt/L2/Create.sh
```

#### Using a Topology
cEOS-Lab nodes do require CPU to get started, but once running CPU utilization will drop down.  Memory utilization for a cEOS-lab instance is anywhere from 300-500 MB.  Make sure your host node is sized appropriately.

Use the following commands to view running containers, stats and connecting to a container.
```
# View running containers
docker ps

# View running and stopped containers
docker ps -a

# View stats of the containers one-time
docker stats --no-stream

# View a continuous update for container stats. Stop with Ctrl + C
docker stats

# Connect to a cEOS-Lab instance.
docker exec -it l2leaf1 Cli -p 15

# Connect to a host instance.
docker exec -it l2host11 bash
```
