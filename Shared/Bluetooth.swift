//
//  Bluetooth.swift
//  CleanUV
//
//  Created by Christopher Ortega on 03/06/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import CoreBluetooth

protocol BluetoothProtocol {
    func state(state: Bluetooth.State)
    func list(list: [Bluetooth.Device])
    func Value(data: Data)
}

final class Bluetooth: NSObject{
    static let shared = Bluetooth()
    var delegate: BluetoothProtocol?
        
    var peripherals = [Device]()
    var current : CBPeripheral?
    var state: State = .unknown {
        didSet {
            delegate?.state(state : state)
        }
    }
    
    private var manager : CBCentralManager?
    private var readCharacteristic : CBCharacteristic?
    private var writeCharacteristic : CBCharacteristic?
    private var notifyCharacteristic : CBCharacteristic?
    
    private override init() {
        super.init()
        manager = CBCentralManager(delegate: self, queue: .none)
        manager?.delegate = self
    }
    
    func Connect(_ peripherial: CBPeripheral){
        if current != nil {
            guard let current = current else {
                return
            }
            manager?.cancelPeripheralConnection(current)
            manager?.connect(peripherial, options: nil)
        } else {
            manager?.connect(peripherial, options: nil)
        }
    }
    
    func disconnect(){
        guard let current = current else {
            return
        }
        manager?.cancelPeripheralConnection(current)
    }
    
    func StartScanning(){
        peripherals.removeAll()
        manager?.scanForPeripherals(withServices: nil, options: nil)
    }
    func StopScanning(){
        peripherals.removeAll()
        manager?.stopScan()
    }
    
    func send(_ value: [UInt8]){
        guard let characteristic = writeCharacteristic else { return}
        current?.writeValue(Data(value), for: characteristic, type: .withResponse)
    }
    
    enum State{
        case unknown, resetting, unsupported, unauthorized, poweroff, powerOn, error, connected, disconnected
    }
    
    struct Device: Identifiable{
        let id: Int
        let rssi: Int
        let uuid: String
        let peripheral: CBPeripheral
    }
    
}

extension Bluetooth: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch manager?.state {
        case .unknown : state = .unknown
        case .resetting : state = .resetting
        case .unsupported : state = .unsupported
        case .unauthorized : state = .unauthorized
        case .poweredOff : state = .poweroff
        case .poweredOn : state = .powerOn
        default: state = .error
        
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let uuid = String(describing: peripheral.identifier)
        let filtered = peripherals.filter{$0.uuid == uuid}
        
        if filtered.count == 0{
            guard let _ = peripheral.name else {return}
            let new = Device( id: peripherals.count,rssi: RSSI.intValue, uuid: uuid, peripheral: peripheral)
            peripherals.append(new)
            delegate?.list(list: peripherals)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral, error: Error?) {
        current = nil
        state = .disconnected
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        current = peripheral
        state = .connected
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
}

extension Bluetooth: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
        guard let services = peripheral.services else {return}
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
        for characteristic in characteristics {
            switch characteristic.properties {
            case .read: readCharacteristic = characteristic
            case .write: writeCharacteristic = characteristic
            case .notify: notifyCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            case .indicate: break
            case .broadcast: break
                
            default: break
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("error")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let value = characteristic.value else {return}
        delegate?.Value(data: value)
    }
}
