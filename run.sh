#!/bin/sh

docker run --rm --name="3d-printer" -p5000:5000 -v`pwd`/octoprint:/root/.octoprint --device=/dev/ttyUSB0 lherman/3d-printer
