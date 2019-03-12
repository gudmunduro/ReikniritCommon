import Foundation

// Functions

public func input(_ message: String = "", seperator: String = ": ") -> String?
{
    print(message, terminator: seperator)
    return readLine()
}

public func input(_ message: String = "", seperator: String = ": ") -> Int?
{
    print(message, terminator: seperator)
    let inp = readLine()
    return (inp != nil) ? Int(inp!) : nil
}

public func ask(_ message: String = "") -> Bool
{
    let yesAnswers: [String] = ["já", "ja", "y", "yes", "j"]
    let noAnswers: [String] = ["nei", "n", "no"]

    while true {
        guard let inp: String = input(message, seperator: "? ") else {
            print("Svar er ekki gilt")
            continue
        }

        if yesAnswers.contains(inp.lowercased()) {
            return true
        } else if noAnswers.contains(inp.lowercased()) {
            return false
        } else {
            print("Svar er ekki gilt")
            continue
        }
    }
}

func deg(_ value: Double) -> Double
{
    return value * 180 / Double.pi
}

func deg(_ value: Float) -> Float
{
    return value * 180 / Float.pi
}

enum GraphPosition {
    case PP
    case NP
    case NN
    case PN

    static func find(x: Double, y: Double) -> GraphPosition
    {
        if x >= 0 && y > 0 {
            return .PP
        } else if x < 0 && y > 0 {
            return .NP
        } else if x < 0 && y <= 0 {
            return .NN
        } else if x >= 0 && y <= 0 {
            return .PN
        }
        return .PP
    }
}

// Function overloads

public func sqrt(_ value: Int) -> Int
{
    return Int(sqrt(Double(value)))
}

public func acos(_ value: Int) -> Int
{
    return Int(acos(Double(value)))
}

public func pow(_ value: Int, _ power: Int) -> Int 
{
    return Int(pow(Double(value), Double(power)))
}

// Classes

public class Menu {

    let title: String
    public fileprivate(set) var options: [(text: String, option: () -> Void)]

    init(title: String, options: [(text: String, option: () -> Void)])
    {
        self.title = title
        self.options = options
    }

    convenience init(options: [(text: String, option: () -> Void)])
    {
        self.init(title: "", options: options)
    }

    func show()
    {
        print(title)
        for i in 0..<options.count {
            print("\(i + 1)) \(options[i].text)")
        }
        while true {
            guard let selected: Int = input(), 1...options.count ~= selected else {
                print("Invalid selection")
                continue
            }

            print("--\(options[selected - 1].text)--")
            print("")
            do {
                options[selected-1].option()
            } catch {
                print("Failed to run option")
                print(error)
            }
            print("")
            break
        }
    }
}

// Extensions

extension Int {

    static postfix func ++ (lhs: inout Int) -> Int {
        lhs += 1
        return lhs
    }
}

extension Double {

    func rounded(decimals: Int) -> Double {
        return (self * pow(10.0, Double(decimals))).rounded() / pow(10.0, Double(decimals))
    }

}

extension String {

    subscript (range: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }

    subscript (value: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: value)
        let endIndex = self.index(self.startIndex, offsetBy: value + 1)
        return String(self[startIndex..<endIndex])
    }
}

extension Array {

    mutating func swap(_ ind1: Int, _ ind2: Int) {
        let temp = self[ind1]
        self[ind1] = self[ind2]
        self[ind2] = temp
    }

    func printAll() {
        for element in self {
            print(element)
        }
    }
}