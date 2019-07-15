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
        print("--------dgm: hasIndex ----------")
        print("Finding:\(chr) in \(str)")
        for c in str {
            if c == chr {
                return true
            }
        }
        return false
    }
    
    func handleInput(str: String) {
        
        if let i = userInput.firstIndex(of: "-") {
            userInput.remove(at: i) // Strip off the first character if it's a dash
            print("--------dgm: strip dash ----------")
            print(userInput)
        } else {
            print("1: userInput=\(userInput)")
            userInput += str
            print("2: userInput=\(userInput)")
        }
        accumulator = Double((userInput as NSString).doubleValue)
        print("---------dgm: handleInput --------")
        print("accumulator=\(accumulator)")
        updateDisplay()
    }
    
    func updateDisplay() {
        // If the value is an integer, don't show a decimal point

        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            print("--------dgm: updateDisplay if ----------")
            print("accumulator=\(accumulator)")
            print("iAcc=\(String(iAcc))")
            numField.text = "\(iAcc)"
        } else {
            numField.text = "\(accumulator)"
        }
        print("--------dgm: updateDisplay----------")
        print("accumulator=\(accumulator)")
        print("userInput=\(userInput)")

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
            print("opStack=\(opStack)")
            let oper = ops[opStack.removeLast()] // pulls the function indexed by the last string in opStack
            print("numStack=\(numStack)")
            //print("numStack removeLast=\(numStack.removeLast())")
            print("accumulator pre operation =\(accumulator)")
            accumulator = oper!(numStack.removeLast(), accumulator)
            print("accumulator post operation =\(accumulator)")
            if !opStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }

    // UI Set-up
    @IBOutlet var numField: UITextField!
    
// Move to implementing button presses using tags
// Tag numbering scheme.
//      0-9 number keys have the same tags (e.g., 0 key has tag 0)
//      For all other keys, the 2-digit tag number is rowColumn. Row 1, column 1 is upper left button.
//          (e.g., = button is tag 43)
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        handleInput(str: String(sender.tag))
    }
    
    @IBAction func btnDecPress(_ sender: UIButton) {
        if hasIndex(stringToSearch: userInput, characterToFind: ".") == false {
            handleInput(str: ".")
            print("--------dgm: btnDecPress----------")
        }
    }
   
    @IBAction func btnCHSPress(_ sender: UIButton) {
        print("--------dgm: btnCHSPress ----------")
//        if userInput.isEmpty {
//            userInput = numField.text!
//        }
        accumulator *= -1.0
        userInput = String(accumulator)
        updateDisplay()
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

