#!/usr/bin/env bash
if [[ $(which flutter) == *"flutter-win"* ]]; then
    cmd.exe /c "flutter test --coverage"
else
    flutter test --coverage
fi

sed -i -e s_\\\\_/_g ./coverage/lcov.info
genhtml -out coverage -q ./coverage/lcov.info
