//
//  ContentView.swift
//  WeSplit
//
//  Created by Kyle Housel on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercentage = 20
    @State private var badTipper = false
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section(header: Text("How much would you like to tip?").font(.subheadline).foregroundColor(.black).headerProminence(.increased).italic()) {
                        
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) { tip in
                                Text("\(tip)%")
                            }
                            
                            
                        }
                        .pickerStyle(.segmented)
                        
                        
                        
                    }
                    
                    Section(header: Text("Total per person").font(.headline).foregroundColor(tipPercentage == 0 ? .red : .green).headerProminence(.increased).bold()) {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            
                    }
                }
            }
            .navigationTitle("We$plit")
            .navigationBarTitleDisplayMode(.large)
            .font(.headline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }

    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
