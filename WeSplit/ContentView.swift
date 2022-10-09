//
//  ContentView.swift
//  WeSplit
//
//  Created by Ben Printac on 09/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkamount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPrecentage = 10
    @FocusState private var IsFocus:Bool
    let tipPrecentages = [5, 10, 12, 15, 20]

    var TotalPerPersion:Double {
        let TotalPeople:Double = Double(numberOfPeople + 1)
        let TotalPercentage: Double = Double(tipPrecentage) / 100
        return (((Double(checkamount))*TotalPercentage) + checkamount) / TotalPeople
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount",value: $checkamount, format: .currency(code:Locale.current.currency?.identifier ?? "ILS")).keyboardType(.decimalPad).focused($IsFocus)
                    
                    Picker("Diners",selection: $numberOfPeople){
                        ForEach(1..<31){
                            Text("\($0) people")
                            }
                        }
                }header: {
                    Text("Total Amount:")
                }
                Section {
                    Picker("Tip", selection: $tipPrecentage){
                        ForEach(tipPrecentages, id: \.self){
                            Text($0,format: .percent)
                            }
                        }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip:")
                }
                
                Section{
                    Text(TotalPerPersion,format:.currency(code: Locale.current.currency?.identifier ?? "ILS"))
                }header: {
                    Text("Total Price Per Person:")
                }
            }
            .navigationTitle("SplitHelper")
            .toolbar{
                ToolbarItemGroup(placement:.keyboard){
                    Spacer()
                    Button("Done"){
                        IsFocus = false
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
