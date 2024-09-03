#!/bin/bash

CONFIG_FILE="pipewire.conf"
SOURCE_PATH="/usr/share/pipewire/"$CONFIG_FILE
DESTINY_PATH="/etc/pipewire"
RESAMPLE_PATH=$DESTINY_PATH"/client.conf.d/resample.conf"

cp $SOURCE_PATH $DESTINY_PATH

echo "Added pipewire.conf file."

sed -i 's/#default\.clock\.rate[ \t]*=[ \t]*48000/default.clock.rate = 192000/' "$DESTINY_PATH/$CONFIG_FILE"
sed -i 's/#default\.clock\.allowed-rates[ \t]*=[ \t]*\[ 48000 \]/default.clock.allowed-rates = [ 44100 48000 96000 192000 ]/' "$DESTINY_PATH/$CONFIG_FILE"

echo "Enabled new samplerates."

echo 'stream.properties = {
    resample.quality = 10
}' > "$RESAMPLE_PATH"

echo "resample.conf file created and resample quality set."