
import SwiftUI

struct ContentView: View {
    var body: some View {
        
        GeometryReader{ geometry in
            NavigationView{
               
                VStack(spacing:100){
                    
                    Text("Prediction Game")
                        .font(.largeTitle)
                        .foregroundColor(Color .gray)
                    
                    Image("dice").resizable()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.25, alignment: .center)
                    
                    NavigationLink(destination:(PredictionView())){
                        Text("Start Game")
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1, alignment: .center)
                            .font(.largeTitle)
                            .foregroundColor(Color .white)
                            .background(Color .pink)
                            .cornerRadius(20)
                    }
                }.navigationTitle("HomePage")
            }
        }
    }
}
struct PredictionView: View {
    
    @State private var variable = ""
    @State private var Status:Bool = false
    @State private var result = false
    
    @State private var remainingLife:Int = 5
    @State private var clue = ""
    @State private var randomNumber:Int = 0
    var body: some View {
        
            
            VStack(spacing:80){
                
                Text("Prediction Game")
                    .font(.largeTitle)
                    .foregroundColor(Color .gray)
                
                Text("Remaining Life : \(remainingLife)")
                
                //Clue
                Text(clue)
                
                TextField("Enter Number",text: $variable)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action:{
                    print("button click")
                    self.remainingLife -= 1
                    
                    // Checking that it receives a numeric value as input from the user
                    
                    if let broughtValue = Int(self.variable){
                        // we form our terms according to the remaining right
                        if self.remainingLife != 0 {
                            // Based on the Prediction Result we create the condition of our code in our hint
                            if (broughtValue > self.randomNumber){
                                self.clue = "decrease"
                            }
                            if (broughtValue < self.randomNumber){
                                self.clue = "increase"
                            }
                            if (broughtValue == self.randomNumber){
                                self.result = true// will be sent to the result screen according to the result
                                self.Status = true
                                resetGame()
                            }
                        
                        }
                        //Our rights are gone
                        else{
                            
                            self.result = false
                            self.Status = true
                            
                            // To reset the Screen when we want to Play the Game Again
                            resetGame()
                        }
                        
                    }
                    
                    self.variable = ""
                    
                }){
                    Text("Prediction")
                        .frame(width: 200, height: 80, alignment: .center)
                        .font(.largeTitle)
                        .foregroundColor(Color .white)
                        .background(Color .pink)
                        .cornerRadius(20)
                }
                    
                    
            }.navigationTitle("Prediction Page")
             // page transition
            .sheet(isPresented:$Status) { //  We perform a page transition with the sheet() method.
                ResultView(incomingResult:self.result)
            }
        //We write the Codes that will be executed when the page appears. ( onAppear() )
            .onAppear(){
                
                self.randomNumber = Int.random(in: 0...100)
                print(randomNumber)
            }
    }
    func resetGame(){
        self.clue = ""
        self.remainingLife = 5
        self.randomNumber = Int.random(in: 0...100)
    }
}
struct ResultView: View {
    
    // we use @SwiftUI.Environment(\.presentationMode) to say close the page
   
    @SwiftUI.Environment(\.presentationMode) var  myPresentationMode
    
    var incomingResult:Bool? // show image by result
    
    
    var body: some View {
        VStack(spacing:80){
            
            if incomingResult! {
                Image("happy").resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                Text("Won")
                    .foregroundColor(Color .pink)
            }
            else{
                
                
                Image("sad").resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                Text("Lost")
                    .foregroundColor(Color .pink)
            }
            
            Button(action: {
                print("button click")
                self.myPresentationMode.wrappedValue.dismiss() // to close the page and return to the previous page.
            }){
                Text("Again Play")
                    .frame(width: 200, height: 80, alignment: .center)
                    .font(.largeTitle)
                    .foregroundColor(Color .white)
                    .background(Color .pink)
                    .cornerRadius(20)
            }
                
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
