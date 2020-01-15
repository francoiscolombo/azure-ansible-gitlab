#!/bin/sh

# not functional yet
pip install simpleblog-1.0.0-py3-none-any.whl
waitress-serve --call simpleblog:create_app