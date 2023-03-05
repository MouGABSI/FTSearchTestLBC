//
//  DynamicValue.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import Foundation
/**
 A class that wraps a value of a given type and allows observers to be notified when the value changes.
 
 Example:
 let dynamicValue = DynamicValue<String>("Hello")
 dynamicValue.addObserver(self) {
 print("The value has changed to (dynamicValue.value)")
 }
 dynamicValue.value = "World"
 // Output: "The value has changed to World"
 */
class DynamicValue<T> {
    typealias CompletionHandler = ((T?) -> Void)
    /// The wrapped value.
    var value: T {
        didSet {
            self.notify()
        }
    }
    
    /// A dictionary that maps weak references to observer objects to completion handlers.
    private var observers = [WeakObjectWrapper<AnyObject>: CompletionHandler]()
    /**
     Initializes a new `DynamicValue` object with the given value.
     
     - Parameter value: The initial value to wrap.
     */
    init(_ value: T) {
        self.value = value
    }
    /**
     Adds an observer object and a completion handler to the dictionary of observers.
     
     - Parameters:
     - observer: The observer object to add.
     - completionHandler: The completion handler to call when the value changes.
     */
    public func addObserver(_ observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        let wrapper = WeakObjectWrapper(observer)
        observers[wrapper] = completionHandler
    }
    /**
     Adds an observer object and a completion handler, and immediately calls the `notify` method.
     
     - Parameters:
     - observer: The observer object to add.
     - completionHandler: The completion handler to call when the value changes.
     */
    public func addAndNotify(observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        //remove any observers that have been deallocated.
        observers = observers.filter { $0.key.value != nil }
        //call the completion handler of each non deallocated observer
        observers.forEach { $0.value(value) }
    }
    /**
     Removes all observers from the dictionary when the `DynamicValue` object is deallocated.
     */
    deinit {
        observers.removeAll()
    }
}
/**
 A private class that wraps a weak reference to an object of type `T`.
 */
private class WeakObjectWrapper<T: AnyObject>: Hashable {
    /// The weakly referenced object.
    weak var value: T?
    
    /**
     Initializes a new `WeakObjectWrapper` object with the given object.
     
     - Parameter value: The object to wrap.
     */
    init(_ value: T) {
        self.value = value
    }
    /**
     Returns true if two `WeakObjectWrapper` objects are equal.
     
     - Parameters:
     - lhs: The left-hand side `WeakObjectWrapper` object.
     - rhs: The right-hand side `WeakObjectWrapper` object.
     
     - Returns: `true` if the two objects are equal, `false` otherwise.
     */
    static func == (lhs: WeakObjectWrapper<T>, rhs: WeakObjectWrapper<T>) -> Bool {
        return lhs.value === rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        // Check if the 'value' property is not nil
        if let nonNilValue = value {
            // If it's not nil, combine its hash value with the hasher
            hasher.combine(ObjectIdentifier(nonNilValue).hashValue)
        } else {
            // If it's nil, combine a unique negative value with the hasher
            hasher.combine(-1)
        }
    }
}


class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
