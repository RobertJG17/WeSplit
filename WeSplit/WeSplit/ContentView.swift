//
//  ContentView.swift
//  WeSplit
//
//  Created by Robert Guerra on 10/26/20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // Computed Property
    var totalPerPerson: Double {
        // Grab proper values and convert to Doubles
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage]) / 100
        let orderAmount = Double(checkAmount) ?? 0
        
        // Calculate parts and then amount per person
        let tipValue = orderAmount * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var total: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalPerPerson * peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
            }.navigationTitle("WeSplit")
        }
        Form {
            Section(header: Text("How much would you like to tip?")) {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0..<tipPercentages.count) {
                        Text("\(self.tipPercentages[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Grand Total:")){
                Text("$\(total, specifier: "%.2f")")
            }
            Section(header: Text("Payment per person:")) {
                Text("$\(totalPerPerson, specifier: "%.2f")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
