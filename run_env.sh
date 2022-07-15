if [[ $NERSC_HOST = "cori" ]]; then
    export machine=cori
elif [[ $(uname -s) = "Darwin" ]]; then
    export machine=mac
elif [[ $(dnsdomainname) = "summit.olcf.ornl.gov" ]]; then
    export machine=summit
elif [[ $(cat /etc/os-release | grep "PRETTY_NAME") == *"Ubuntu"* || $(cat /etc/os-release | grep "PRETTY_NAME") == *"Debian"* ]]; then
    export machine=unknownlinux
fi
export GPTUNEROOT=$PWD
export MPIRUN=/gpfs/fs1/home/jkoo/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-9.2.0/openmpi-4.1.2-fvux2w2ghkfoznxvlaitivemwqkhtscr/bin/mpirun
export PYTHONPATH=/gpfs/fs1/home/jkoo/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-9.2.0/gptune-2.1.0-5tshb6qz3ev5d2wbmganmzrmbpwwbq76/lib/python3.8/site-packages/gptune:$PYTHONPATH
export proc=$(spack arch)
export mpi=openmpi
export compiler=gcc
export nodes=1 
export cores=4 
export ModuleEnv=$machine-$proc-$mpi-$compiler 
software_json=$(echo ",\"software_configuration\":{\"openblas\":{\"version_split\": [0,3,19]},\"openmpi\":{\"version_split\": [4,1,2]},\"netlib-scalapack\":{\"version_split\": [2,1,0]},\"gcc\":{\"version_split\": [9,2,0]}}") 
loadable_software_json=$(echo ",\"loadable_software_configurations\":{\"openblas\":{\"version_split\": [0,3,19]},\"openmpi\":{\"version_split\": [4,1,2]},\"netlib-scalapack\":{\"version_split\": [2,1,0]},\"gcc\":{\"version_split\": [9,2,0]}}") 
machine_json=$(echo ",\"machine_configuration\":{\"machine_name\":\"$machine\",\"$proc\":{\"nodes\":$nodes,\"cores\":$cores}}") 
loadable_machine_json=$(echo ",\"loadable_machine_configurations\":{\"$machine\":{\"$proc\":{\"nodes\":$nodes,\"cores\":$cores}}}") 
