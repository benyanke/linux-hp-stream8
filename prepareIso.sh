#!/bin/bash

# Update these
export iso32="http://cdimage.ubuntu.com/ubuntu-budgie/releases/18.04.1/release/ubuntu-budgie-18.04.1-desktop-i386.iso"
export iso32Sha2="c2807074f3581b59f99c03c6a7c70f117684cced3ffe9d133d8bdacf192958e3"
export iso64="http://cdimage.ubuntu.com/ubuntu-budgie/releases/18.04.1/release/ubuntu-budgie-18.04.1-desktop-amd64.iso"
export iso64Sha2=""
export multiArchIso="http://cdimage.debian.org/debian-cd/current/multi-arch/iso-cd/debian-9.5.0-amd64-i386-netinst.iso"
export multiArchIsoSha2="9865794883a54c3f599d3da5b1293110e4da4340d0a24d1af3d90ee7bf94c8df"

# This should be fine
export tmpDir="/tmp/isoConversion/$USER"


# Download ISO if don't exist AND the hash doesn't match
function getIso() {

  isoRole="$1"
  expectedHash="$2"
  isoToFetch="$3"
  isoLocalPath="$tmpDir/isoDw/$isoRole.iso"

  mkdir -p "$tmpDir/isoDw" &> /dev/null

  # Check if iso is already downloaded before attempting
  if [ ! -f "$isoLocalPath" ]; then
    echo "File not found! Fetching iso for $isoRole now"
    wget "$isoToFetch" -O "$isoLocalPath"
  else
    echo "File found!"
    # TODO : VERIFY HASH HERE
    return;
  fi


}


getIso "iso32"  "$iso32Sha2"  "$iso32"

exit;
getIso "iso"  "$iso64Sha2"  "$iso64" &
getIso "iso"  "$iso64Sha2"  "$iso64" &
getIso "efiFileIso"  "$multiArchIso"  "$multiArchIsoSha2" &
wait

