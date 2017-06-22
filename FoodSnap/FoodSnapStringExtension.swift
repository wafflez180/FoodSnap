//
//  FoodSnapStringExtension.swift
//  FoodSnap
//
//  Created by Arthur De Araujo on 6/22/17.
//  Copyright © 2017 Arthur De Araujo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}
