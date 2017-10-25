import bluetooth
from bluetooth.ble import DiscoveryService

#service = DiscoveryService()
service = BeaconService("hci1")
devices = service.discover(2)

for address, name in devices.items():
    print("name: {}, address: {}".format(name, address))

