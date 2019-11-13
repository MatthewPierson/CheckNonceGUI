#!/bin/bash

cd "$(dirname "$0")"

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

./igetnonce | grep 'n112ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPod9,1"
   echo $device
fi

./igetnonce | grep 'j171ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,11"
   echo $device
fi

./igetnonce | grep 'j17ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,12"
   echo $device
fi

./igetnonce | grep 'j71bap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,5"
   echo $device
fi

./igetnonce | grep 'j72bap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,6"
   echo $device
fi

./igetnonce | grep 'j73ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,3"
   echo $device
fi

./igetnonce | grep 'j87ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,6"
   echo $device
fi

./igetnonce | grep 'j85map' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,7"
   echo $device
fi

./igetnonce | grep 'j86map' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,8"
   echo $device
fi

./igetnonce | grep 'j87map' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,9"
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

./irecovery -f junk.txt

./irecovery -f ibss."$device".img4

if [ $device = iPhone6,1 ] || [ $device = iPhone6,2 ] || [ $device = iPad4,1 ] || [ $device = iPad4,2 ] || [ $device = iPad4,3 ] || [ $device = iPad4,4 ] || [ $device = iPad4,5 ] || [ $device = iPad4,6 ] || [ $device = iPad4,7 ] || [ $device = iPad4,8 ] || [ $device = iPad4,9 ];
then
    ./irecovery -f ibec."$device".img4
fi

echo "Ready for nonce =)"
exit 0
