#!/bin/bash

echo "Getting certificates..."
echo $APPLE_DEV_CERTIFICATE | base64 --decode > certificate.p12

echo "Creating temporary keychain..."
security create-keychain -p temps build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p temps build.keychain

echo "Importing keychains..."
security import certificate.p12 -k build.keychain -P $CERT_PASSWORD -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple: -s -k temps build.keychain

echo "Attempting to find identities..."
security find-identity -v
# xcodebuild -scheme termina-base -project termina-base.xcodeproj -derivedDataPath dist build
# xcodebuild -scheme termina-base -project termina-base.xcodeproj -derivedDataPath dist build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO