//
//  LiveData.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/1.
//

import Foundation

/// 可观察数据
///
/// ViewModel的数据使用，可观察数据变化
@propertyWrapper
public class LiveData<Value> {
    public var wrappedValue: Value {
        didSet {
            observerHandler?(wrappedValue)
        }
    }

    deinit {
        debugPrint("\(self) did is deinit")
    }

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public var projectedValue: LiveData<Value> {
        return self
    }

    private var observerHandler: ((Value) -> Void)?

    public func observer(handler: ((Value) -> Void)?) {
        observerHandler = handler
        handler?(wrappedValue)
    }

    public func bind<Subject>(to observer: Subject) where Subject: Observer, Subject.Value == Value {
        observerHandler = observer.observer(_:)
        observerHandler?(wrappedValue)
    }
}

public protocol Observer {
    associatedtype Value

    func observer(_ value: Value)
}
