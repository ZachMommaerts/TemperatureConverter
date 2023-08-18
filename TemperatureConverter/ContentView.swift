//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Zach Mommaerts on 8/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var temperatureInput = 0.0
    @State private var selectedInput = "Fahrenheit"
    @State private var selectedOutput = "Celsius"
    @FocusState private var inputIsFocused: Bool
    
    private let scales = ["Fahrenheit", "Celsius", "Kelvin"]
    
    private var temperatureOutput: Double {
        if selectedInput == "Fahrenheit" {
            if selectedOutput == "Celsius" {
                return (temperatureInput - 32) * 5/9
            } else if selectedOutput == "Kelvin" {
                return (temperatureInput - 32) * 5/9 + 273.15
            }
        } else if selectedInput == "Celsius" {
            if selectedOutput == "Fahrenheit" {
                return (temperatureInput * 9/5) + 32
            } else if selectedOutput == "Kelvin" {
                return temperatureInput + 273.15
            }
        } else if selectedInput == "Kelvin" {
            if selectedOutput == "Fahrenheit" {
                return (temperatureInput - 273.15) * 9/5 + 32
            } else if selectedOutput == "Celsius" {
                return temperatureInput - 273.15
            }
        }
        
        return temperatureInput
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("Temperature Scale", selection: $selectedInput) {
                        ForEach(scales, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Temperature", value: $temperatureInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Temperature Scale", selection: $selectedOutput) {
                        ForEach(scales, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(temperatureOutput, format: .number)
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        inputIsFocused = false
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
