import Combine
import Foundation

enum MyError: Error {
    case myError
}

//check("Empty") {
//    Empty<Int, SampleError>()
//}
//
//check("Just") {
//    Just("Hello SwiftUI")
//}
/*
check("Catch and Continue") {
    ["1", "2", "Swift", "4"].publisher
        .print("[Original]")
        .flatMap { s in
            return Just(s)
                .tryMap { s -> Int in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
            }
            .print("[ TryMap ]")
            .catch { _ in
                Just(-1).print("[  Just  ]") }
                .print("[  Catch ]")
    }
}
*/
//check("Contains") {
//[1,2,3,4,5].publisher
//    .print("[Original]")
//    .contains(5)
//}

//check("drop") {
//    ["A", "B", "C"].publisher
//        .flatMap { l in
//            [1, 2, 3].publisher
//                .map { "\(l)\($0)" }
//        }
//}

/*
class Clock {
    var timeString: String = "--:--:--" {
        didSet { print("\(timeString)") }
    }
}

let clock = Clock()

let formatter = DateFormatter()
formatter.timeStyle = .medium

let timer = Timer.publish(every: 1, on: .main, in: .default)
var token = timer
    .map { formatter.string(from: $0) }
    .assign(to: \.timeString, on: clock)

timer.connect()
*/

/*
struct Response: Decodable {
    struct Foo: Decodable {
        let foo: String
    }
    let args: Foo?
}

let searchText = PassthroughSubject<String, Never>()

var components = URLComponents()
components.scheme = "https"
components.host = "httpbin.org"
components.path = "/get"

let debounce = check("Debounce") {

    searchText.scan("") { $0 == "" ? "\($1)" : "\($0) \($1)" }
        .debounce(for: .seconds(1), scheduler: RunLoop.main)
        .map { url -> URL in
            components.queryItems = [URLQueryItem(name: "foo", value: url)]
            return components.url!
    }
    .flatMap {
        return URLSession.shared
            .dataTaskPublisher(for: $0)
            .map { data, _ in data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .compactMap { $0.args?.foo }
            .replaceError(with: "")
    }
}

delay(0.1) { searchText.send("I") }
delay(0.2) { searchText.send("Love") }
delay(0.5) { searchText.send("SwiftUI") }
delay(1.6) { searchText.send("And") }
delay(2.0) { searchText.send("Combine") }

// 希望的输出：
// ----- Debounce -----
// receive subscription: xxx
// request unlimited
// receive value: (I Love SwiftUI)
// receive value: (I Love SwiftUI And Combine)
*/

/*
let searchText = PassthroughSubject<String, Never>()

let throttle = check("throttle") {
    
    searchText
//        .debounce(for: .seconds(1), scheduler: RunLoop.main)
        .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
    
}

delay(0.1) { searchText.send("I") }
delay(0.2) { searchText.send("Love") }
delay(0.5) { searchText.send("SwiftUI") }
delay(1.6) { searchText.send("And") }
delay(2.0) { searchText.send("Combine") }
*/
