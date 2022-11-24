//
//  ContentView.swift
//  tinyMeasurements
//
//  Created by Jennifer Biggs on 11/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var convertFrom = 0
    @State private var convertTo = 0
    @State private var value = ""
    @FocusState private var amountIsFocused: Bool
    
    enum Unit: String, CaseIterable {
        case millileters
        case teaspoons
        case tablespoons
        
        var unitVolume: UnitVolume {
            switch self {
            case .millileters: return UnitVolume.milliliters
            case .teaspoons: return UnitVolume.imperialTeaspoons
            case .tablespoons: return UnitVolume.imperialTablespoons
            }
        }
    }
    
    var inputUnits : String {
        if convertFrom == 0 {
           return "millileters"
        }
        if convertFrom == 1 {
           return "teaspoons"
        }
        else {
            return "tablespoons"
        }
    }
    
    var outputUnits : String {
        if convertTo == 0 {
           return "millileters"
        }
        if convertTo == 1 {
           return "teaspoons"
        }
        else {
            return "tablespoons"
        }
    }
    
    let volumeUnits = Unit
        .allCases
        .compactMap { $0.rawValue }
    
    var output: Double {
        guard let value = Double(self.value) else {
            return 0
        }
        guard let convertFrom = Unit(rawValue: volumeUnits[self.convertFrom]) else {
            return 0
        }
        guard let convertTo = Unit(rawValue: volumeUnits[self.convertTo]) else {
            return 0
        }
        return Measurement(
            value: value,
            unit: convertFrom.unitVolume
        )
        .converted(to: convertTo.unitVolume)
        .value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $value)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Input", selection: $convertFrom) {
                        ForEach(0..<volumeUnits.count) {
                            Text(self.volumeUnits[$0])
                        }
                    } .pickerStyle(.segmented)
                } header: {
                            Text("Convert From")
                    }
                    Section {
                        Text("\(output, specifier: "%.2f")")
                        Picker("Output", selection: $convertTo) {
                            ForEach(0..<volumeUnits.count) {
                                Text(self.volumeUnits[$0])
                            }
                        } .pickerStyle(.segmented)
                    } header: {
                        Text("Convert To")
                    }
                    .navigationTitle("Tiny Measurements")
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

