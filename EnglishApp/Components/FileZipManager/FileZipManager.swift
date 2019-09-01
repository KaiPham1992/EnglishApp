//
//  FileManager.swift
//  EnglishApp
//
//  Created by Steve on 8/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire
import Zip

class FileZipManager {
    static let shared  = FileZipManager()
    init() {
    }
    func downLoadFile(idDictionary: Int, link: String, completion : @escaping (() -> ())){
        DispatchQueue.main.async {
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            Alamofire.download(link,to: destination).responseData { response in
                if response.result.isSuccess, let destinationURL = response.destinationURL, let unzipURL = self.unzipFile(link: destinationURL)  {
                    SQLHelper.shared.convertSQLiteToRealmWordEntity(idDictionary: idDictionary, path: unzipURL.path + "/sqliteWord.db", complete: {
                        if let url = URL(string: unzipURL.path + "/sqliteWord.db") {
                            self.removeFile(link: url)
                        }
                    })
                    SQLHelper.shared.convertSQLiteToRealmWordExplainEntity(idDictionary: idDictionary, path: unzipURL.path + "/sqliteWordExplain.db", complete: {
                        if let url = URL(string: unzipURL.path + "/sqliteWordExplain.db") {
                            self.removeFile(link: url)
                        }
                        completion()
                    })
                }
            }
        }
    }
    
    func unzipFile(link: URL) -> URL?{
        do {
            let unzipDirectory = try Zip.quickUnzipFile(link)
            removeFile(link: link)
            return unzipDirectory
        } catch {
            print(error)
        }
        return nil
    }
    
    func removeFile(link : URL) {
        do {
            try FileManager.default.removeItem(atPath: link.path)
            print("remove file successed")
        } catch {
            print("remove file failed")
        }
    }
}
