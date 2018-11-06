#!/bin/bash

echo $APPLE_DEV_CERTIFICATE | base64 --decode > certificate.p12
security create-keychain -p temps build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p temps build.keychain
security import certificate.p12 -k build.keychain -P $CERT_PASSWORD
security set-key-partition-list -S apple-tool:,apple: -s -k temps build.keychain
xcodebuild -scheme termina-base -project termina-base.xcodeproj -derivedDataPath dist build
# xcodebuild -scheme termina-base -project termina-base.xcodeproj -derivedDataPath dist build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO