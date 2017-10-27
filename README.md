# 4970 
## Bluetooth LE 
### First time
```
bluetoothctl
agent on 
default-agent
power on 
scan on
[ get device MAC address ]
scan off
pair <addr> 
connect <addr>
```

### Attempt to connect
```
sudo bluetoothctl 2>&1 | tee /tmp/bluetooth.out
connect DC:2A:9C:FB:8C:D3 
select-attribute /org/bluez/hci0/dev_DC_2A_9C_FB_8C_D3/service0021/char0022
notify on
```

### Parse output
```
cat /tmp/bluetooth.out | awk 'BEGIN {FS=Value:}; {print $2}'
```

## Links
[Archlinux Wiki - Bluetooth](https://wiki.archlinux.org/index.php/bluetooth#Bluetoothctl)
[Bluetooth LE on Raspberry Pi](https://www.elinux.org/RPi_Bluetooth_LE)
[Bluetooth LE Quick Start](https://www.jaredwolff.com/blog/get-started-with-bluetooth-low-energy/)  
[Bluetooth Low Energy Introduction](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/introduction)  
