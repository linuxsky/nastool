#!/bin/bash
cd /volume1/docker/nastool
tar zcvf docker.tar.gz -C /volume1/docker/nastool/docker .
tar zcvf video.tar.gz -C /volume1/docker/nastool/video .
cd ..
cd ..
cd