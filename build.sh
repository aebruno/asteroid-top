#!/bin/bash

#==============================================================================
# AsteroidOS Go build script
#==============================================================================
#
# This script assumes you have built the Asteroid SDK cross compilation
# toolchain and have Go >= 1.7.1 installed with a proper GOPATH.
#
# You will also need to have installed Qt 5.7.0 (the official prebuilt package).
#
# The build script performs the following functions:
#
# - Bootstrap github.com/therecipe/qt Go bindings
# - Runs qtmoc, qtrcc and qtminmal code generation
# - Compiles asteroid binary

APPNAME=asteroid-top
QT_VERSION=5.7.0
GOQT_VERSION=cc0c5bf2f27659e5956687c3bf66d1f7b4ddd40d

case "$1" in
        prep)
            QT_VERSION=$QT_VERSION $GOPATH/bin/qtmoc $PWD/model
            QT_VERSION=$QT_VERSION $GOPATH/bin/qtrcc $PWD
            QT_VERSION=$QT_VERSION $GOPATH/bin/qtminimal asteroid $PWD
            ;;
        compile)
            rm -f $APPNAME
            GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 CPATH=$OE_QMAKE_INCDIR_QT \
            LIBRARY_PATH=$OE_QMAKE_LIBDIR_QT \
            CGO_LDFLAGS=--sysroot=$SDKTARGETSYSROOT \
            go build -ldflags="-s -w" -tags="minimal asteroid" \
            -installsuffix=asteroid -o $APPNAME 2>&1 | egrep '\.go'
            #-installsuffix=asteroid -o $APPNAME
            if [ ! -f $APPNAME ]; then echo "Failed to compile."; fi
            ;;
        clean)
            rm -f $APPNAME rrc.cpp  rrc.go  rrc.qrc model/moc_* model/moc.{go,cpp,h}
            ;;
        bootstrap-qt)
            pushd .
            mkdir -p $GOPATH/src/github.com/therecipe
            cd $GOPATH/src/github.com/therecipe
            git clone https://github.com/therecipe/qt
            cd qt
            git checkout $GOQT_VERSION
            cd cmd/qtsetup
            go install .
            cd ../qtmoc
            go install .
            cd ../qtminimal
            go install .
            popd
            ;;
        *)
            echo $"Usage: $0 {prep|compile|clean|bootstrap-qt}"
            exit 1
 
esac
