//
//  UserDefaultPersistence.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

// got this idea from an article, long time ago and since I'm evolving it.
@propertyWrapper
struct Persist<T: Codable> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data {
                return (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
            }

            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                guard ((newValue as? NSString) == nil) ||
                    ((newValue as? NSNumber) == nil) ||
                    ((newValue as? NSDate) == nil) ||
                    ((newValue as? NSArray) == nil) ||
                    ((newValue as? NSDictionary) == nil) else {
                    UserDefaults.standard.set(newValue, forKey: key)
                    return
                }

                if let data = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(data, forKey: key)
                } else {
                    UserDefaults.standard.set(newValue, forKey: key)
                }
            }
        }
    }
}
