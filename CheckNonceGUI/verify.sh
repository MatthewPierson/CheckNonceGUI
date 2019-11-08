#!/bin/bash

cd "$(dirname "$0")"

if [ -z "$1" ]
then
    echo "No shsh path set"
    echo "Exiting.."
    exit 1
else
    echo "Shsh path found"
fi

shshpath="$1"

echo $shshpath


./igetnonce | grep 'n53ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone6,2"
   echo $device
fi

./igetnonce | grep 'n51ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone6,1"
   echo $device
fi

./igetnonce | grep 'j71ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,1"
   echo $device
fi

./igetnonce | grep 'j72ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,2"
   echo $device
fi

./igetnonce | grep 'j85ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,4"
   echo $device
fi

./igetnonce | grep 'j86ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,5"
   echo $device
fi
./igetnonce | grep 'd11ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,2"
   echo $device
fi
./igetnonce | grep 'd10ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,1"
   echo $device
fi
./igetnonce | grep 'd101ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,3"
   echo $device
fi
./igetnonce | grep 'd111ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,4"
   echo $device
fi
./igetnonce | grep 'd22ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone10,3"
   echo $device
fi
./igetnonce | grep 'd221ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone10,6"
   echo $device
fi

if [ -z "$device" ]
then
    echo "Either unsupported device or no device found."
    echo "Exiting.."
    exit 1
else
    echo "Supported device found."
fi

shshNonce=$(./img4tool -s $shshpath | grep "BNCH: BNCH: " | cut -d' ' -f 3)
echo $shshNonce

ret=$(./igetnonce 2>/dev/null | grep ApNonce)
deviceNonce=$(echo $ret | cut -d '=' -f 2 )
echo $deviceNonce

if [ $deviceNonce != $shshNonce ]; then
    echo "Failed verification"
    exit 1
fi
if [ $deviceNonce = $shshNonce ]; then
    echo "Passed verification"
    exit 0
fi
    


