#!/bin/bash

CWD=$(pwd)
PROJECT_DIR=$(dirname $0)/../../
BUILD_DIR=$PROJECT_DIR/moonshot/build/$(date +"%s")
OUTPUT_FILE=output.tar.gz

mkdir $BUILD_DIR
cp $PROJECT_DIR/moonshot/appspec.yml $BUILD_DIR
cp -r $PROJECT_DIR/moonshot/bin $BUILD_DIR
cp -r $PROJECT_DIR/app_name $BUILD_DIR

cd $BUILD_DIR
tar -zcvf output.tar.gz ./
cd $CWD

mv $BUILD_DIR/output.tar.gz $OUTPUT_FILE
rm -rf $BUILD_DIR
