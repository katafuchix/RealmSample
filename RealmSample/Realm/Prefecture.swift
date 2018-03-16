//
//  Prefecture.swift
//  RealmSample
//
//  Created by cano on 2018/03/17.
//  Copyright © 2018年 cano. All rights reserved.
//

import RealmSwift

open class Prefecture: Object {
    @objc dynamic var id: Int64 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var order: Int64 = 0 //並び順の番号
    @objc dynamic var memo : String = ""
    
    //インデックスの設定
    override open static func indexedProperties() -> [String] {
        return ["id"]
    }
    //プライマリキーの設定
    override open static func primaryKey() -> String? {
        return "id"
    }
}

