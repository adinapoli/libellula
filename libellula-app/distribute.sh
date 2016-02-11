#!/bin/bash

echo "Packing your app.."
rm -rf build
mkdir -p build
asar pack . build/app.asar
cp build/app.asar /Applications/Libellula.app/Contents/Resources/app.asar
echo "All done."
