//
//  ContentView.swift
//  tinyMeasurements
//
//  Created by Jennifer Biggs on 11/22/22.
//

import SwiftUI

struct ContentView: View {
    let measurementOptions = ["millileters", "teaspoons", "tablespoons"]
    @State private var convertFrom = "millileters"
    @State private var convertTo = "teaspoons"
    @State private var value = 5.0
    @FocusState private var amountIsFocused: Bool
    
    private let formatStyle = Measurement<UnitVolume>.FormatStyle(
           width: .wide,
           numberFormatStyle: .number
       )
    
    var output = 5.4
    
    
    
    var convertedValue: Measurement<UnitVolume> {
        switch convertFrom {
        case "millileters" :
            let convertFromMillileters = Measurement(value: value, unit: UnitVolume.milliliters)
            if convertTo == "teaspoons" {
                let convertedValue = convertFromMillileters.converted(to: UnitVolume.imperialTeaspoons)
                return convertedValue
            }
            else {
                let convertedValue = convertFromMillileters.converted(to: UnitVolume.imperialTablespoons)
                return convertedValue
            }
        case "teaspoons" :
            let convertFromTeaspoons = Measurement(value: value, unit: UnitVolume.imperialTeaspoons)
            if convertTo == "tablespoons" {
                let convertedValue = convertFromTeaspoons.converted(to: UnitVolume.imperialTablespoons)
                return convertedValue
            } else {
                let convertedValue = convertFromTeaspoons.converted(to: UnitVolume.milliliters)
                return convertedValue
            }
        case "tablespoons" :
            let convertFromTablespoons = Measurement(value: value, unit: UnitVolume.imperialTablespoons)
            if convertTo == "teaspoons" {
                let convertedValue = convertFromTablespoons.converted(to: UnitVolume.imperialTeaspoons)
                return convertedValue
            } else {
                let convertedValue = convertFromTablespoons.converted(to: UnitVolume.milliliters)
                return convertedValue
            }
        default :
            let convertedValue = Measurement(value: 0, unit: UnitVolume.milliliters)
            return convertedValue
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input", selection: $convertFrom) {
                        ForEach(measurementOptions, id:\.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Convert From")
                }
                
                Section {
                    Picker("Output", selection: $convertTo) {
                        ForEach(measurementOptions, id:\.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Convert To")
                }
                
                Section {
                    TextField("Amount", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("How many \(convertFrom)?")
                }
                
                Section {
                    Text(convertedValue, format: .measurement(width: .wide))
                } header: {
                    Text("Converted to \(convertTo)")
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
