#!/bin/bash

strip=`xcrun -sdk iphoneos --find bitcode_strip`

strip_it () {
    local file=$1

    echo "before"
    ls -la $file
    echo "...bitcode_strip..."
    $strip -r $file -o $file
    echo "after"
    ls -la $file
    echo ""
}

#strip_it Pods/MapboxMobileEvents/MapboxMobileEvents.xcframework/ios-arm64_armv7/MapboxMobileEvents.framework/MapboxMobileEvents

strip_it Pods/Giphy/GiphySDK/GiphyUISDK.xcframework/ios-arm64_armv7/GiphyUISDK.framework/GiphyUISDK
