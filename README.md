# 4970 
## Bluetooth LE 
### pybluez[ble] dependencies
```
sudo apt-get install libbluetooth-dev \
libboost-python-dev \
libboost-thread-dev
sudo pip install pybluez[ble]
```
### Scan for devices
```
hcitool -i hci1 lescan
^C
```

### Attempt to connect
```
gattool -b DC:2A:9C:FB:8C:D3 -I
> connect
> primary
```
#### Alternative 
```
hcitool -i hci1 lecc --random DC:2A:9C:FB:8C:D3
```
## Issues

## Links
[Bluetooth LE Quick Start](https://www.jaredwolff.com/blog/get-started-with-bluetooth-low-energy/)  
[Bluetooth Low Energy Introduction](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/introduction)  

