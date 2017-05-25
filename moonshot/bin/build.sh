#!/bin/bash

CWD=$(pwd)
PROJECT_DIR=$(dirname $0)/../../
BUILD_DIR=$PROJECT_DIR/moonshot/build/$(date +"%s")
OUTPUT_FILE=output.tar.gz

mkdir $BUILD_DIR
mkdir $BUILD_DIR/lap_tracker

cp $PROJECT_DIR/moonshot/appspec.yml $BUILD_DIR
cp -r $PROJECT_DIR/moonshot/bin $BUILD_DIR
cp $PROJECT_DIR/Gemfile $BUILD_DIR/lap_tracker/
cp $PROJECT_DIR/config.ru $BUILD_DIR/lap_tracker/
cp -r $PROJECT_DIR/src $BUILD_DIR/lap_tracker/src
cp -r $PROJECT_DIR/config $BUILD_DIR/lap_tracker/config

cd $BUILD_DIR
tar -zcvf output.tar.gz ./
cd $CWD

mv $BUILD_DIR/output.tar.gz $OUTPUT_FILE
rm -rf $BUILD_DIR
