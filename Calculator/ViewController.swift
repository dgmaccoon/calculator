import UIKit

// Basic math functions
func add(a: Double, b: Double) -> Double {
    return a + b
}
func sub(a: Double, b: Double) -> Double {
    return a - b
}
func mul(a: Double, b: Double) -> Double {
    return a * b
}
func div(a: Double, b: Double) -> Double {
    return a / b
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "/" : div ]

class ViewController: UIViewController {
    
    var accumulator: Double = 0.0 // Store the calculated value here
    var userInput = "" // User-entered digits
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    
    // Looks for a single character in a string.
    func hasIndex(stringToSearch str: String, characterToFind chr: Character) -> Bool {
        for c in str {
            if c == chr {
                return true
            }
        }
        return false
    }
    
    func handleInput(str: String) {

//        if str == "-" {
//            if userInput.hasPrefix(str) {
//                // Strip off the first character (a dash)
//                userInput = userInput.substringFromIndex(userInput.startIndex.successor())
//
//                let index = str.firstIndex(of:"-") ?? str.endIndex
//                let end = str[index...]
        
        if let i = userInput.firstIndex(of: "-") {
            userInput.remove(at: i) // Strip off the first character if it's a dash
            print(userInput)
        } else {
            userInput += str
        }
        accumulator = Double((userInput as NSString).doubleValue)
        updateDisplay()
    }
    
    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            numField.text = "\(iAcc)"
        } else {
            numField.text = "\(accumulator)"
        }
    }
    
    func doMath(newOp: String) {
        if userInput != "" && !numStack.isEmpty {
            let stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                let oper = ops[opStack.removeLast()]
                accumulator = oper!(numStack.removeLast(), accumulator)
                doEquals()
            }
        }
        opStack.append(newOp)
        numStack.append(accumulator)
        userInput = ""
        updateDisplay()
    }
    
    func doEquals() {
        if userInput == "" {
            return
        }
        if !numStack.isEmpty {
            let oper = ops[opStack.removeLast()]
            accumulator = oper!(numStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }

    // UI Set-up
    @IBOutlet var numField: UITextField!
    @IBOutlet var btnClear: UIButton!
    @IBOutlet var bntEquals: UIButton!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var btnSubtract: UIButton!
    @IBOutlet var btnMultiply: UIButton!
    @IBOutlet var btnDivide: UIButton!
    @IBOutlet var btnDecimal: UIButton!
    
    @IBOutlet var btn0: UIButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!


    @IBAction func btn0Press(sender: UIButton) {
        handleInput(str: "0")
    }
    @IBAction func btn1Press(sender: UIButton) {
        handleInput(str: "1")
    }
    @IBAction func btn2Press(sender: UIButton) {
        handleInput(str: "2")
    }
    @IBAction func btn3Press(sender: UIButton) {
        handleInput(str: "3")
    }
    @IBAction func btn4Press(sender: UIButton) {
        handleInput(str: "4")
    }
    @IBAction func btn5Press(sender: UIButton) {
        handleInput(str: "5")
    }
    @IBAction func btn6Press(sender: UIButton) {
        handleInput(str: "6")
    }
    @IBAction func btn7Press(sender: UIButton) {
        handleInput(str: "7")
    }
    @IBAction func btn8Press(sender: UIButton) {
        handleInput(str: "8")
    }
    @IBAction func btn9Press(sender: UIButton) {
        handleInput(str: "9")
    }
    
    @IBAction func btnDecPress(sender: UIButton) {
        if hasIndex(stringToSearch: userInput, characterToFind: ".") == false {
            handleInput(str: ".")
        }
    }
    
    @IBAction func btnCHSPress(sender: UIButton) {
        if userInput.isEmpty {
            userInput = numField.text!
        }
        handleInput(str: "-")
    }
    
    @IBAction func btnACPress(sender: UIButton) {
        userInput = ""
        accumulator = 0
        updateDisplay()
        numStack.removeAll()
        opStack.removeAll()
    }
    
    @IBAction func btnPlusPress(sender: UIButton) {
        doMath(newOp: "+")
    }
    
    @IBAction func btnMinusPress(sender: UIButton) {
        doMath(newOp: "-")
    }
    
    @IBAction func btnMultiplyPress(sender: UIButton) {
        doMath(newOp: "*")
    }
    
    @IBAction func btnDividePress(sender: UIButton) {
        doMath(newOp: "/")
    }
    
    @IBAction func btnEqualsPress(sender: UIButton) {
        doEquals()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

