#!/bin/bash

stack build
echo "Copy all.js..."
cp $(stack path --dist-dir)/build/flipped-classroom-frontend/flipped-classroom-frontend.jsexe/all.js demo/
echo "All done."
