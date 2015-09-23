//: Playground - noun: a place where people can play

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

var str = "Hello, playground"

let a = Variable(1)
let b = combineLatest(a, Variable(1), +)

var ret: Int = 0
b.subscribeNext { next in
    ret = next
}

print(ret)                             // => 2

a.value(10)                               // aを書き換える

print(ret)

let source: Observable<Int> = create { (observer: ObserverOf<Int>) in
    sendNext(observer, 42)
    sendCompleted(observer)
    return AnonymousDisposable {
        print("disposed")
    }
}

let subscription = source.subscribe { (event: Event<Int>) -> Void in
    switch event {
    case .Next(let element):
        print("Next: \(element)")
    case .Completed:
        print("Completed")
    case .Error(let error):
        print("Error: \(error)")
    }
}

let source2: Observable<Int> = deferred {
    return just(42)
}

let subscription2 = source2.subscribe { (event: Event<Int>) -> Void in
    switch event {
    case .Next(let element):
        print("Next: \(element)")
    case .Completed:
        print("Completed")
    case .Error(let error):
        print("Error: \(error)")
    }
}