//
//  String+Resource.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

extension String {

    /**
     Gets the resource of a url. Ex: https://swapi.com/planets/12 -> planets/12
     */
    var resourcePath: String? {
        let components = self.dropLast().components(separatedBy: "/")
        
        let count = components.count
        guard count > 2 else { return nil }
        
        let resource = components[count-2]
        let index = components[count-1]
        return "\(resource)/\(index)"
    }

}
