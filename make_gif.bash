#!/bin/bash

convert frame*.png -set delay 1x30 preview.gif
rm frame*.png
