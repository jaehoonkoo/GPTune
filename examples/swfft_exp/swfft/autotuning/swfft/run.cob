#!/bin/bash

module swap PrgEnv-intel PrgEnv-gnu
module load gcc
module unload darshan
# fftw
module load cray-libsci
module load cray-fftw

unset FFTW_WRAPPER
root=$(dirname $FFTW_DIR)
export FFTW_HOME=${root}
export FFTW_INCLUDE=${root}/include
export CPATH=${root}/include:${CPATH}
if [ -f ${root}/lib64 ]
then
export LD_LIBRARY_PATH=${root}/lib64:${LD_LIBRARY_PATH}
else
export LD_LIBRARY_PATH=${root}/lib:${LD_LIBRARY_PATH}
fi
export INFOPATH=${root}/share/info:${INFOPATH}
export MANPATH=${root}/share/man:$MANPATH
export PATH=${root}/bin:${PATH}

export DFFT_FFTW_HOME=${FFTW_HOME}

module load miniconda-3/latest
source activate yt
python3 -m ytopt.search.ambs --evaluator ray --problem problem.Problem --max-evals=3 --learner RF