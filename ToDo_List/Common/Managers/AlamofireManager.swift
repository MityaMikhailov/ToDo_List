//
//  AlamofireManager.swift
//  ToDo_List
//
//  Created by Dmitriy Mikhailov on 02.09.2024.
//

import Foundation
import Alamofire

public final class AlamofireManager {
    
    public static let shared = AlamofireManager()
    
    private let baseURL: String = "https://dummyjson.com"
    private let endpoint: String = "/todos"
    
    private init() {}
    
    func fetchTasksList(completion: @escaping (Result<TaskListAPI, Error>) -> Void ) {
        
        let fullPath = baseURL + endpoint
        
        DispatchQueue.global().async {
            AF.request(fullPath).responseDecodable(of: TaskListAPI.self) { response in
                switch response.result {
                case .success(let success):
                    DispatchQueue.main.async{
                        completion(.success(success))
                    }
                    case .failure(let error):
                    DispatchQueue.main.async{
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
}
