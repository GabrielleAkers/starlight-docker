#!/bin/bash

CHECK_FOR=$VERSION
RUN_AS=$(whoami)

cd "/home/$RUN_AS/data"

if [ -f "/home/$RUN_AS/data/$CHECK_FOR.downloaded" ]; then
    echo "Already downloaded server files, dont need to redownload"
else
    wget "https://cdn.starlight.network/fork/starlight/version/$VERSION/file/SS14.Server_linux-x64.zip" -O "/home/$RUN_AS/data/SS14.zip"
    unzip "/home/$RUN_AS/data/SS14.zip"
    chmod +x "/home/$RUN_AS/data/Robust.Server"
    echo "$CHECK_FOR" > "/home/$RUN_AS/data/$CHECK_FOR.downloaded"
fi

echo "Starting server..."
"/home/$RUN_AS/data/Robust.Server" --config-file "/home/$RUN_AS/server/server_config.toml"