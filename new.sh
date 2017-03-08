#!/bin/bash

readonly filename="src/$(date '+%Y-%m-%d').md"
touch "$filename"
vim "$filename"
