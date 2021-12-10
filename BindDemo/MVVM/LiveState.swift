//
//  LiveState.swift
//  BindDemo
//
//  Created by youzy01 on 2021/12/9.
//

import Foundation

/// 可观察状态
///
/// ViewModel的状态使用，可观察状态变化
@propertyWrapper
public class LiveState<State> {
    public var wrappedValue: State {
        didSet {
            observerHandler?(wrappedValue)
        }
    }

    deinit {
        debugPrint("\(self) did is deinit")
    }

    public init(wrappedValue: State) {
        self.wrappedValue = wrappedValue
    }

    public var projectedValue: LiveState<State> {
        return self
    }

    private var observerHandler: ((State) -> Void)?

    public func bind<Subject>(to observer: Subject) where Subject: StateObserver, Subject.State == State {
        observerHandler = observer.onChanged(value:)
        observerHandler?(wrappedValue)
    }
}

public protocol StateObserver {
    associatedtype State

    func onChanged(value: State)
}

