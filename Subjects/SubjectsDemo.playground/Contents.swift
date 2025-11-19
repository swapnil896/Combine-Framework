import UIKit
import Combine

//============================================================
// a Subject is a special type of publisher that can also act as a subscriber

//===================== PassthroughSubject =======================================

let subject = PassthroughSubject<Int, Never>() // Initial value not required

subject.send(-1)
let cancellable = subject.sink { value in
    print(value)
}

subject.send(1)
subject.send(2)
subject.send(3)

/*--------------------
OUTPUT :-
 1
 2
 3
--------------------*/


//===================== CurrentValueSubject =======================================
let currentValueSubject = CurrentValueSubject<String, Never>("John") // Initial value required

let cancellable2 = currentValueSubject.sink { value in
    print(value)
}

currentValueSubject.send("Mary")

/*--------------------
OUTPUT :-
 John
 Mary
--------------------*/

// Retains the last value
print(currentValueSubject.value)
