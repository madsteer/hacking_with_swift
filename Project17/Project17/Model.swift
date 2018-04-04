//
//  Model.swift
//  Project17
//
//  Created by Cory Steers on 4/3/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import Foundation

enum ForceBomb {
    case never, always, random
}

enum SequenceType: Int {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain
}
