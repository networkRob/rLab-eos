## rLab EOS Topologies

This repo will contain the data models and configs to build different toplogies to run EOS as a container.

### Requirements
To run the network topology on a container host machine, there are a few requirements and tested software versions that are known to work.

#### Distribution Testing
| Distro    | Version | Runtimes        |
| --------- | ------- | --------------- |
| CentOS    | 7       | Docker          |
| Fedora    | >=34    | Docker, Podman  |
| Ubuntu    | >= 22.04| Docker, Podman  |

#### Container Runtimes
| Package   | Version   |
| --------- | --------- |
| Docker    | >= 20.10  |
| Podman    | >= 3.4    |

#### Linux Packages
- bridge-utils
- net-tools
- graphviz
- Docker or Podman
- python3-pip

#### Python3 Packages
- ruamel.yaml
- graphviz
- pydot
- jsonrpclib


### Getting Started
To build a new topology, the following files/data structures need to be created.
- `build/password_hash.py` - This script will generate a SHA512 hashed password to be entered into the topology yaml file.
- `examples/topologies/{name}.yaml` - This directory containers some example/sample topology files to help get started. These can be copied to the `topologies/` directory for use.
- `topologies/{name}.yaml` - This file is leveraged by `build/topo-builder.py` to create the necessary commands to build the topology.
- `build/yamlviz.py` This script will draw a cabling diagram of your topology. It writes a PNG image named after your topology in the `topologies/` directory. 
- `build/topo-build.sh` This is a wrapper script that calls both `build/topo-builder.py` and `build/yamlviz.py`
- `configs/{topo}/{device}` - This directory structure is were any files you want to be loaded into cEOS-lab's `/mnt/flash` should be loaded to.  Scripts, startup-config etc.


To install the necessary packages and libraries enter the following commands: (Fedora example below)

```
sudo dnf install bridge-utils net-tools graphviz docker podman python3-pip
pip3 install -r requirements.txt
```

To leverage Podman for containers, cgroups_v2 will need to be disabled. A reboot is required after for the change.

```
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
sudo reboot now
```

#### NOTE:
To be able to run MLAG and dot1q, use the 4.23.1F or newer release of cEOS-Lab.

#### Topology File Format
There are some required fields to be specified in the topology files.  See the examples listed in the `topologies/` directory.  The required parameters are:
```
topology:
  name: {TOPO_NAME}
  vforward: 1
  cvpaddress: {CVP_IPADDRESS}
  cvp-key: {CVP_KEY}
  username: {USERNAME}
  password: {PASSWORD}
cv:
  nodes: 
    - {CV_NODE}
  port: {CV_PORT}
  auth:
    cert: {CV_ONBOARDING_TOKEN}
    path: /mnt/flash
infra:
  bridge: {MGMT_BRIDGE}
  gateway: {MGMT_NETWORK_GATEWAY}
  mac_mgmt: {MAC_MGMT}
images:
  registry: {LOCATION}
  ceos: {ceosimage_tag}
  64-bit: {CEOSTYPE}
  host: {chostimage_tag}
links:
  - [["spine1", "et1"], ["spine2", "et1"]]
  - [["spine1", "et2"], ["leaf1", "et1"]]
  - [["leaf1", "et3"], ["host10", "et0"]]
nodes:
  - name: spine1
    mac: 00:1c:73:c0:c6:01
    ipaddress: 192.168.0.10
hosts:
  - name: host10
    ipaddress: 10.0.12.11
    mask: 255.255.255.0
    gateway: 10.0.12.1
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

- The `CVP_IPADDRESS` parameter is optional, this is if a bare startup-config is created and the device should start streaming to CVP. (Deprecated)
- The `CVP_KEY` parameter is optional, this is if a bare startup-config is created and the device should start streaming to CVP. (Deprecated)
- The `CV_NODE` This paramter is to specity the address of the CV instance. Can be a list of Addresses
- The `CV_PORT` This paramter is to specify the destination port for CV. On-Prem = `9910`, CVaaS = `443`
- The `CV_ONBOARDING_TOKEN` This parameter is to be populated with a device enrollment token from CV
- The `USERNAME` parameter is optional, this is if a bare startup-config is created. It will generate a local user account in EOS.
- The `PASSWORD` parameter is optional, this is if a bare startup-config is created. It will generate the password for the local user account.
- The `MGMT_BRIDGE` parameter is optional, this is if you wish to attach the cEOS containers Management0 Interface to this network.
- The `MGMT_NETWORK_GATEWAY` parameter is optional, this is if a bare startup-config is created, but should be specified if the `MGMT_BRIDGE` parameter is set.
- The `MAC_MGMT` parameter lets the script know, if the supplied MAC Address for each node should be used for the System ID or Ma0 Interface. (bool) True/False
- The `LOCATION` parameter should be set to `local` as default. Update this to the url of any private/remote registries.
- The `CEOSTYPE` parameter is used to specify if the ceosimage should be `ceosimage` or `ceosimage-64`. (bool) true/false
- The `mac` section for each cEOS-lab node needs to be unique, this sets the mgmt interface MAC Address which also sets the system-id.
- The `links` section is used to create a "virtual" patch cable between each node.
- If you do not want to run iperf on the host nodes, you can leave that section empty and only set `iperf:`
- The `commands:` section can create additional bash scripts to load new configurations on the nodes.  The `topologies/ratd.yaml` file has examples for this.

## Creating a Topology

Clone this repo to your container host node and enter the main directory for this repo.

Here are the steps required to get it running for the first time. Examples for both Docker and Podman are given.

1. Import a cEOS-lab container archive:
```
docker import cEOS-lab.tar.xz ceosimage:{ceosimage_tag}
sudo podman import cEOS-lab.tar.xz ceosimage:{ceosimage_tag}
```
{ceosimage_tag} = tag for the image, ie `4.23.1F`

2. Build and tag the host node:
```
docker build -t chost:{chostimage_tag} build/hosts/.
sudo podman build -t chost:{chostimage_tag} build/hosts/.
```
{chostimage_tag} = tag for the image, ie `0.5`

3. Copy or create a topology definition file. Example definition files are found in `examples/topologies`. As a quick-start, copy one of the definition files to the `topologies/` directory. Otherwise you may create your own topology definition file and save it in `topologies/`

```
cp examples/topologies/l2.yaml topologies
```

4. Create the topology scripts:
To create the necessary scripts and leverage either no startup-configs or leverage already provided ones:
```
./topo-build.sh -t {topo}
```

{topo} is the filename for the topology file located in `topologies/` without the `.yaml` extension. For the L2 topology, the command would look like:
```
topo-build.sh -t l2
```
Note: `topo-build.sh` is a wrapper shell script that calls both `topo-builder.py` and `yamlviz.py`. If the diagram that `yamlviz.py` generates is not needed or to use other arguments to `topo-builder.py`, you can run it directly:
```
build/topo-builder.py -t {topo}
```

To update the container runtime (Docker is default) run with the `-r` flag:

{runtime} is the container runtime options. Available options are: `docker` or `podman`
```
./topo-build.sh -t {topo} -r {runtime}
```
or
```
build/topo-builder.py -t {topo} -r {runtime}
```

To create the necessary scripts and create a bare startup-configuration:
```
./topo-build.sh -t {topo} -s
```

or

```
build/topo-builder.py -t {topo} -s
```

5. The `topo-builder.py` script will create a minimum of 4 bash scripts.  They are located in `scripts/{TOPO_NAME}/`.  It is important to run the commands for the project directories top-level directory.
The four main scripts created are as follows with their description:
- `Create.sh` - Creates all Open vSwitch bridges, containers, starts containers and links all containers together.
- `Start.sh` - Starts all stopped containers and links all containers together.
- `Stop.sh` - Disconnects all links between containers and stops running containers.
- `Delete.sh` - Disconnects all links between containeres, stops running containers, removes containers, and removes Open vSwitch bridges.

An example on creating and starting a new topology, use the following command:
```
bash scripts/L2/Create.sh
```

#### Using a Topology
cEOS-Lab nodes do require CPU to get started, but once running CPU utilization will drop down.  Memory utilization for a cEOS-lab instance is anywhere from 300-500 MB.  Make sure your host node is sized appropriately.

Use the following commands to view running containers, stats and connecting to a container.
#### Docker Example
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

#### Podman Example
```
# View running containers
sudo podman ps

# View running and stopped containers
sudo podman ps -a

# View stats of the containers one-time
sudo podman stats --no-stream

# View a continuous update for container stats. Stop with Ctrl + C
sudo podman stats

# Connect to a cEOS-Lab instance.
sudo podman exec -it l2leaf1 Cli -p 15

# Connect to a host instance.
sudo podman exec -it l2host11 bash
```
