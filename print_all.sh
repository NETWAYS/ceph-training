#!/bin/bash

# should be called inside print.sh
# Generate handouts and also refresh static content
showoff static print
wkhtmltopdf -s A5 --print-media-type --footer-left [page] --footer-right '© NETWAYS' static/index.html ceph-training-handouts.pdf
