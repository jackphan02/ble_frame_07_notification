//
//  ContentView.swift
//  BleFrame
//
//  Created by Jack Phan on 6/11/23.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var bluetoothViewModel = BleCommViewModel()
    
    var body: some View {
        NavigationStack {
            
            List {
                
                ForEach(bluetoothViewModel.foundPeripherals) { ele in
                    
                    NavigationLink(destination: DetailView(oneDev: ele, bleViewModel: bluetoothViewModel)) {
                        PeripheralCell(onePeri: ele)
                    }

                }
                
            }
            .navigationBarTitle("BLE")
                        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PeripheralCell: View {
        
    @ObservedObject var onePeri: UserBlePeripheral
    var body: some View {
        
        LabeledContent {
            Text("\(onePeri.rssi) dBm")
          
        } label: {
            Text(onePeri.name)
            Text(String(onePeri.userPeripheral.identifier.uuidString.suffix(8)))  // show only last 8 chars
            
            //Text(String(onePeri.userPeripheral.identifier.uuidString))              // show all chars
        }
            
    }
        
}
