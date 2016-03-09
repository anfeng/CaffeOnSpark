#!/bin/bash
# This script must be run with sudo.
# for libopencv-dev-2.4
add-apt-repository -y ppa:kubuntu-ppa/backports
# for proto2.5
add-apt-repository -y ppa:chris-lea/protobuf
apt-get -y update
./caffe-public/scripts/travis/travis_install.sh
# install boost
export PATH=$CONDA_DIR/bin:$PATH
if [ "$PYTHON_VERSION" -eq "3" ]; then
  wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
else
  wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O miniconda.sh
fi
chmod +x miniconda.sh
./miniconda.sh -b -p $CONDA_DIR

conda update --yes conda
# The version of boost we're using for Python 3 depends on 3.4 for now.
if [ "$PYTHON_VERSION" -eq "3" ]; then
  conda install --yes python=3.4
fi
conda install --yes numpy scipy matplotlib scikit-image pip
# Let conda install boost (so that boost_python matches)
conda install --yes -c https://conda.binstar.org/menpo boost=1.56.0
