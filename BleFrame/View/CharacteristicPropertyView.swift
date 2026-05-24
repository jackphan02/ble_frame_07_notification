//
//  CharacteristicPropertyView.swift
//  BleFrame
//
//  Created by Jack Phan on 8/24/23.
//

import SwiftUI
import Foundation
import CoreBluetooth

struct CharacteristicPropertyView: View {
    
    @StateObject public var oneChar: UserBleCharacteristic
    @StateObject public var oneDevPeri: UserBlePeripheral
    @State private var showAlert = false
    
    var body: some View {
        
        Text("Chars: \(oneChar.characteristicName)")
        Text(" \(oneChar.uuid.uuidString)")

        Spacer().frame(height: 20)
        // MARK: - Chars property permission
        Grid(horizontalSpacing: 70, verticalSpacing: 10) {
                    
            GridRow {
                Text("Readable").gridColumnAlignment(.trailing)
                if isCharsReadable() { Text("Yes") }
                else { Text("No") }

            }

            GridRow {
                Text("Writeable").gridColumnAlignment(.trailing)
                if isCharsWriteable() { Text("Yes") }
                else { Text("No") }

            }
            
            GridRow {
                Text("Notification").gridColumnAlignment(.trailing)
                if isCharsNotification() { Text("Yes") }
                else { Text("No") }

            }

        }
        
        // MARK: - end: Chars properties
        
        // MARK: - Chars perperty operation
        VStack (alignment: .leading){
            Spacer().frame(height: 20)
            
            // MARK: - NOTIFICATION
            HStack (alignment: .center) {
                if isCharsNotification() {
                    
                    Spacer().frame(width: 10)
                    if !oneChar.characteristic.isNotifying {
                        
                        Button(action: {
                            if oneDevPeri.userPeripheral.state != CBPeripheralState.connected {
                                print("NOT CONNECTED")
                                showAlert = true
                            }
                            else {
                                
                                // will set enble notification
                                oneDevPeri.userPeripheral.setNotifyValue(true, for: oneChar.characteristic)
                            }
                            
                        })  {
                            Text("Enable notification")
                                .padding()
                                .frame(width: 170.0, height: 40.0)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Spacer().frame(width: 25)
                        Text("Notification is OFF")
                        
                    }
                    else {
                        
                        Button(action: {
                            
                            if oneDevPeri.userPeripheral.state != CBPeripheralState.connected {
                                print("NOT CONNECTED")
                                showAlert = true

                            }
                            else {
                                // will set disable notification
                                oneDevPeri.userPeripheral.setNotifyValue(false, for: oneChar.characteristic)
                            }
                            
                        })  {
                            Text("Disable notification")
                                .frame(width: 170.0, height: 40.0)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        
                        Spacer().frame(width: 25)
                        Text("Notification is ON")

                    }
                    
                }
            }
            
            // MARK: - END NOTIFICATION
            
        }
        .alert("Device disconnected", isPresented: $showAlert) {
            }
        
        Spacer()
    }
    
    func isCharsReadable() -> Bool {
        
        if(oneChar.characteristic.properties.rawValue &
           CBCharacteristicProperties.read.rawValue) == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    func isCharsWriteable() -> Bool {
        
        if(oneChar.characteristic.properties.rawValue &
           CBCharacteristicProperties.write.rawValue) == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    func isCharsNotification() -> Bool {
        
        if(oneChar.characteristic.properties.rawValue &
           CBCharacteristicProperties.notify.rawValue) == 0 {
            return false
        }
        else {
            return true
        }
    }
}

