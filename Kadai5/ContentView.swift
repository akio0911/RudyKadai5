//
//  ContentView.swift
//  Kadai5
//

import SwiftUI

struct ContentView: View {
    @State private var inputTextNum1: String = ""
    @State private var inputTextNum2: String = ""
    @State private var answerLabel: String = "Label"
    @State private var whichAlert: AlertType = AlertType.num1Invalid
    @State var onAlert = false

    enum AlertType {
        case num1Invalid
        case num2Invalid
        case divByZero
    }

    func checkNumAndCalcAnswer() {
        if Int(inputTextNum1) == nil {
            self.whichAlert = .num1Invalid
        } else if Int(inputTextNum2) == nil {
            self.whichAlert = .num2Invalid
        } else if Int(inputTextNum2) == 0 {
            self.whichAlert = .divByZero
        } else {
            onAlert = false
            answerLabel = String(format: "%.1f", Double(inputTextNum1)! / Double(inputTextNum2)!)
            return
        }
        onAlert = true
        return
    }

    var body: some View {
        ZStack {
            Color.white.opacity(0.01)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.closeKeyboard()
                    print("close keyboadr")
                }
            VStack(spacing: 50) {
                HStack {
                    InputNumField(textNum: $inputTextNum1)
                    Text("÷")
                    InputNumField(textNum: $inputTextNum2)
                }
                Button(action: {
                    checkNumAndCalcAnswer()
                }, label: {
                    Text("計算")
                }).alert(isPresented: $onAlert) {
                    switch whichAlert {
                    case.num1Invalid:
                        return Alert(title: Text("課題5"),
                                     message: Text("割られる数を入力して下さい"),
                                     dismissButton: .default(Text("OK")))
                    case.num2Invalid:
                        return Alert(title: Text("課題5"),
                                     message: Text("割る数を入力して下さい"),
                                     dismissButton: .default(Text("OK")))
                    case.divByZero:
                        return Alert(title: Text("課題5"),
                                     message: Text("割る数には0を入力しないで下さい"),
                                     dismissButton: .default(Text("OK")))
                    }
                    }
                Text(answerLabel)
            }.padding()
        }
    }
}

struct InputNumField: View {
    @Binding var textNum: String

    var body: some View {
        TextField("", text: Binding(
                    get: { self.textNum },
                    set: { self.textNum = $0.filter {"0123456789".contains($0)} }))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
