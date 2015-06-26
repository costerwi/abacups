#!/bin/sh
# This is a simple script to copy files into the appropriate CUPS directories.

PREFIX=/usr
LIB=$PREFIX/lib
SHARE=$PREFIX/share

BACKEND=$LIB/cups/backend
FILTER=$LIB/cups/filter
MIME=$SHARE/cups/mime
PPD=$SHARE/cups/model

INSTALL=install

echo Checking directories...
for d in $BACKEND $FILTER $MIME $PPD
do
    echo -n $d
    if test -d $d
    then
        if test -w $d
        then
            echo " exists and is writable."
        else
            ERR=1
            echo " exists but is not writable by $(whoami).  Should login as root."
        fi
    else
        ERR=1
        echo " does not exist.  Check CUPS installation."
    fi
done
test -n "$ERR" && exit $ERR

$INSTALL -v       abaqus       $BACKEND
$INSTALL -v       texttoinp    $FILTER
$INSTALL -v -m644 abaqus.convs $MIME
$INSTALL -v -m644 abaqus.types $MIME
$INSTALL -v -m644 abaqus.ppd   $PPD

