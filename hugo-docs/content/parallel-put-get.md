+++
date = "2017-05-27T22:33:04-04:00"
description = "parallel put get test script"
title = "parallel_put_get.sh"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "putget"
    parent = "code"
    weight = 3

+++

### parallel_put_get.sh

This script required the installation of the **parallel** package ([parallel-20160222-1.el7.noarch](https://www.rpmfind.net/linux/RPM/epel/7/aarch64/p/parallel-20160222-1.el7.noarch.html)) to be installed on the CentOS 7 test VMs being used. The configuration shown below would generate 256 40 MB files and transfer them using 30 parallel job threads at a time performing either **iput** or **iget** commands against the target iRODS provider.

The only modification made to this script in the CentOS 7 test environment was to modify the `TARGET_RESOURCE="demoResc"` to be either `galera1Resc`, `galera2Resc`, or `galera3Resc` depending on which node was being pointed at.

```bash
#!/bin/bash -e

###############################
#
# This script will attempt parallel puts and gets
# using the environment's iput/iget iCommands.
#
# This script will exit only when encountering an error.
#
# - JOBS is the number of parallel jobs
#
# - Creates FILES_TO_CREATE FILESIZE_IN_MB MiB files in FILES_FULLPATH
# - Puts the files into BENCHMARKS_COLL
# - Gets the files into BENCHMARKS_FULLPATH
#
###############################

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
TIMESTAMPISH=$( date +%s )${RANDOM}
RELATIVEPATH="scratch_for_parallelputget/${TIMESTAMPISH}"


FILESIZE_IN_MB=40
FILES_TO_CREATE=256
FILES_DIR="${RELATIVEPATH}/files.dir"
BENCHMARKS_COLL="${RELATIVEPATH}/benchmarks.coll"
TARGET_RESOURCE="demoResc"
JOBS=30


FILES_FULLPATH=${SCRIPTPATH}/${FILES_DIR}
BENCHMARKS_FULLPATH=${SCRIPTPATH}/${BENCHMARKS_COLL}

####################################
# generate files
####################################
mkdir -p ${FILES_FULLPATH}
for i in `seq -w ${FILES_TO_CREATE}`
do
    truncate -s${FILESIZE_IN_MB}M ${FILES_FULLPATH}/bigfile.${i}
    echo ${i} >> ${FILES_FULLPATH}/bigfile.${i}
done

####################################
# generate scripts
####################################
mkdir -p ${BENCHMARKS_FULLPATH}
for i in `ls ${FILES_FULLPATH}`
do
    echo iput -R ${TARGET_RESOURCE} -K -f ${FILES_FULLPATH}/${i} ${BENCHMARKS_COLL}/
done > ${BENCHMARKS_FULLPATH}/iput-all
for i in `ls ${FILES_FULLPATH}`
do
    echo iget -R ${TARGET_RESOURCE} -K -f ${BENCHMARKS_COLL}/${i} ${BENCHMARKS_FULLPATH}/
done > ${BENCHMARKS_FULLPATH}/iget-all

####################################
# parallel put and get
####################################
imkdir -p ${BENCHMARKS_COLL}
irm -rf ${BENCHMARKS_COLL}
imkdir -p ${BENCHMARKS_COLL}
COUNT=0
time while [ "$?" == "0" ]; do
    COUNT=$((COUNT+1))
    date
    echo "Starting loop ${COUNT}"
    echo " put"
    cat ${BENCHMARKS_FULLPATH}/iput-all | parallel -j ${JOBS}
    if [ "$?" != "0" ]; then
        date
        exit 1
    fi
    echo " get"
    cat ${BENCHMARKS_FULLPATH}/iget-all | parallel -j ${JOBS}
done
```
