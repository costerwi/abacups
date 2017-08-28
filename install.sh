#!/bin/sh
# This is a simple script to copy files into the appropriate CUPS directories.

PREFIX=/usr
LIB=$PREFIX/lib
SHARE=$PREFIX/share

BACKEND=$LIB/cups/backend
MIME=$SHARE/cups/mime
PPD=$SHARE/cups/model

INSTALL=install

error=$(tput setaf 1)ERROR:$(tput sgr 0) || error="ERROR:"
warning=$(tput setab 3)WARNING:$(tput sgr 0) || warning="WARNING:"

echo Checking system...
if [ ! -x "${PYTHON:=$(type -p python3 || type -p python)}" ]
then
    echo $error python '$PYTHON' is not executable
    ERR=1
fi

if selinuxenabled
then
    echo $warning selinux is $(getenforce)
fi

for d in $BACKEND $MIME $PPD
do
    if test -d $d
    then
        if test -w $d
        then
            echo $d exists and is writable.
        else
            ERR=1
            echo $error $d exists but is not writable by $(whoami).  Should login as root.
        fi
    else
        ERR=1
        echo $error $d does not exist.  Check CUPS installation.
    fi
done
test -n "$ERR" && exit $ERR

if ! grep -q !$PYTHON runjob
then
    echo Updating scripts to use $PYTHON
    sed -i -e 1s:!.*:!$PYTHON: runjob
    sed -i -e 1s:!.*:!$PYTHON: qsub
fi

$INSTALL -v -m500 runjob       $BACKEND
$INSTALL -v -m644 runjob.types $MIME
$INSTALL -v -m644 runjob.ppd   $PPD

lpadmin -p runjob -v runjob: -D "CAE job queue" -E -P $PPD/runjob.ppd
service cups restart

