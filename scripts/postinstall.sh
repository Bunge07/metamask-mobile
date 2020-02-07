#!/bin/bash
echo "PostInstall script:"

echo "1. React Native nodeify..."
node_modules/.bin/rn-nodeify --install 'crypto,buffer,react-native-randombytes,vm,stream,http,https,os,url,net,fs' --hack

echo "2. Patch npm packages"
npx patch-package

# Fix isomorphic-webcrypto for eccrypto
TARGET="node_modules/eccrypto/browser.js"
sed -i'' -e 's/global.crypto || global.msCrypto || {};/require("isomorphic-webcrypto");/' $TARGET;

echo "3. Create xcconfig files..."
echo "" > ios/debug.xcconfig
echo "" > ios/release.xcconfig

echo "4. Init git submodules"
echo "This may take a while..."
git submodule update --init
