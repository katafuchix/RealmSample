//
//  RealmController.swift
//  RealmSample
//
//  Created by cano on 2018/03/17.
//  Copyright © 2018年 cano. All rights reserved.
//

import RealmSwift

class RealmController {
    var realm: Realm?
    
    fileprivate static var realmController: RealmController? = nil
    fileprivate static let SCHEMA_VERSION: UInt64 = 1
    
    open static func getSharedRealmController() -> RealmController {
        if realmController == nil {
            realmController = RealmController()
        }
        return realmController!
    }
    
    init () {
        setDefaultRealmConfig()
        
        do {
            realm = try Realm()
        } catch let error as NSError {
            // handle error
            print("Realm init error" + error.description)
        }
    }
    
    func setDefaultRealmConfig() {
        var config = Realm.Configuration()
        config.schemaVersion = RealmController.SCHEMA_VERSION
        Realm.Configuration.defaultConfiguration = config
    }
    
    // DBマイグレーション処理  タイミング次第では使えないので値を代入する場合は別途実装
    open static func migration() {
        print("------ migration ------")
        //Realmのマイグレーションの処理
        let config = Realm.Configuration(
            // 新しいスキーマバージョンを設定します。以前のバージョンより大きくなければなりません。
            // （スキーマバージョンを設定したことがなければ、最初は0が設定されています）
            schemaVersion: RealmController.SCHEMA_VERSION,
            
            // マイグレーション処理を記述します。古いスキーマバージョンのRealmを開こうとすると
            // 自動的にマイグレーションが実行されます。
            migrationBlock: { migration, oldSchemaVersion in
                print("------ migrationBlock oldSchemaVersion=\(oldSchemaVersion)  ------")
                // 最初のマイグレーションの場合、`oldSchemaVersion`は0です
                if (oldSchemaVersion < 1) {
                }
        })
        
        // デフォルトRealmに新しい設定を適用します
        Realm.Configuration.defaultConfiguration = config
        // Realmファイルを開こうとしたときスキーマバージョンが異なれば、
        // 自動的にマイグレーションが実行されます
        
        do {
            _ = try Realm()
        } catch let error as NSError {
            // print error
            print("Realm migration error" + error.description)
        }
    }
    
    open func addPrefecture(_ id: Int64, _ name: String) {
        // Prefectureオブジェクトを作成する
        let p = Prefecture()
        p.id = id
        p.name = name
        
        // トランザクションを開始して、オブジェクトをRealmに保存
        do {
            try self.realm!.write {
                self.realm!.add(p)
            }
            print("Realm add Prefecture complete. id=\(p.id) name=\(p.name) ")
        } catch let error as NSError {
            print("Realm init error" + error.description)
        }
    }
    
    // 都道府県の取得
    open func getPrefecture(_ id: Int64) -> Prefecture? {
        let ps = self.realm!.objects(Prefecture.self).filter("id = \(id)")
        if ps.count > 0 {
            return ps[0]
        } else {
            return nil
        }
    }
    
    // 都道府県を削除する
    open func deleteGenre(_ id: Int64) {
        let p = self.realm!.objects(Prefecture.self).filter("id = \(id)")
        // トランザクションを開始してオブジェクトを削除
        try! self.realm!.write {
            self.realm!.delete(p)
        }
    }
    
    // 都道府県リストを取得する
    open func getPrefectureList() -> Results<Prefecture> {
        let prefectureList = self.realm!.objects(Prefecture.self).filter("id > 0").sorted(byKeyPath: "order",ascending:true)
        return prefectureList
    }
    
    open func initDefaultPrefecture() {
        let ps = self.realm!.objects(Prefecture.self)
        if ps.count > 0 {
            return
        }
        self.addPrefecture(1,"北海道")
        self.addPrefecture(2,"青森")
        self.addPrefecture(3,"岩手")
        self.addPrefecture(4,"宮城")
        self.addPrefecture(5,"秋田")
        self.addPrefecture(6,"山形")
        self.addPrefecture(7,"福島")
        self.addPrefecture(8,"茨城")
        self.addPrefecture(9,"栃木")
        self.addPrefecture(10,"群馬")
        self.addPrefecture(11,"埼玉")
        self.addPrefecture(12,"千葉")
        self.addPrefecture(13,"東京")
        self.addPrefecture(14,"神奈川")
        self.addPrefecture(15,"新潟")
        self.addPrefecture(16,"富山")
        self.addPrefecture(17,"石川")
        self.addPrefecture(18,"福井")
        self.addPrefecture(19,"山梨")
        self.addPrefecture(20,"長野")
        self.addPrefecture(21,"岐阜")
        self.addPrefecture(22,"静岡")
        self.addPrefecture(23,"愛知")
        self.addPrefecture(24,"三重")
        self.addPrefecture(25,"滋賀")
        self.addPrefecture(26,"京都")
        self.addPrefecture(27,"大阪")
        self.addPrefecture(28,"兵庫")
        self.addPrefecture(29,"奈良")
        self.addPrefecture(30,"和歌山")
        self.addPrefecture(31,"鳥取")
        self.addPrefecture(32,"島根")
        self.addPrefecture(33,"岡山")
        self.addPrefecture(34,"広島")
        self.addPrefecture(35,"山口")
        self.addPrefecture(36,"徳島")
        self.addPrefecture(37,"香川")
        self.addPrefecture(38,"愛媛")
        self.addPrefecture(39,"高知")
        self.addPrefecture(40,"福岡")
        self.addPrefecture(41,"佐賀")
        self.addPrefecture(42,"長崎")
        self.addPrefecture(43,"熊本")
        self.addPrefecture(44,"大分")
        self.addPrefecture(45,"宮崎")
        self.addPrefecture(46,"鹿児島")
        self.addPrefecture(47,"沖縄")
    }
    
}
