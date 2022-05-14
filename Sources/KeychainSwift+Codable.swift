//
//  File.swift
//  
//
//  Created by DuongTH on 15/05/2022.
//

import Foundation

public extension KeychainSwift {
    static let standard: KeychainSwift = KeychainSwift()
    @discardableResult
    func set<E: Encodable>(_ value: E?, forKey key: String,
                           encoder: JSONEncoder = JSONEncoder(),
                           withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        guard let value = value else {
            return delete(key)
        }
        do {
            let data = try encoder.encode(value)
            return set(data, forKey: key, withAccess: access)
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            return false
        }
    }

    func get<D: Decodable>(_ key: String, asReference: Bool = false,
                           decoder: JSONDecoder = JSONDecoder()) -> D? {
        guard let data = self.getData(key, asReference: asReference) else {return nil}
        return try? decoder.decode(D.self, from: data)
    }
}

