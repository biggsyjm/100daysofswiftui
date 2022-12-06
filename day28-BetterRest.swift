//
//  ContentView.swift
//  BetterRest
//
//  Created by Jennifer Biggs on 11/27/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var bedtime = Date.now
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("")) {
//                    Text("When do you want to wake up?")
//                        .font(.headline)
//
                    DatePicker("Wake up at", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .frame(width: 310, alignment: .trailing)
                        
                }
                Section (header: Text("Sleep amount")) {
//                    Text("Desired amount of sleep")
//                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section (header: Text("Coffee consumed")) {
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Daily coffee intake")
//                        .font(.headline)
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
//                    Picker(selection: $coffeeAmount, label: Text("Coffee")) {
//                        ForEach(1..<20, id:\.self) {
//                            Text("\($0) cups")
//                        }
//                    }
                }
                Section (header: Text("Target Bedtime")) {
                    Text("\(bedtime.formatted(date: .omitted, time: .shortened))")
                }
                .onChange(of: sleepAmount ) { _ in
                    calculateBedtime()
                }
                .onChange(of: wakeUp ) { _ in
                    calculateBedtime()
                }
                .onChange(of: coffeeAmount ) { _ in
                    calculateBedtime()
                }
                
                }
            .navigationTitle("BetterRest")
//                .toolbar {
//                    Button("Calculate Bedtime", action: calculateBedtime)
//                }
//                .alert(alertTitle, isPresented: $showingAlert) {
//                    Button("OK") { }
//                }  message: {
//                    Text(alertMessage)
//                }
//

        }
    }
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            bedtime = sleepTime
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
