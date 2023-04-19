//
//  ViewController.swift
//  APICallingAlmofire
//
//  Created by Lalaiya Sahil on 02/02/23.
//

import UIKit
import SwiftUI
import Alamofire

class ViewController: UIViewController {
    
    var arrUsers: [UserDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    private func getUsers(){
        AF.request("https://reqres.in/api/users?page=2").responseData { response in
            debugPrint("Response: \(response)")
            if response.response?.statusCode == 200{
                guard let apiData = response.data else { return }
                do{
                    let userDetails = try JSONDecoder().decode(UserDetailsApiResponse.self, from: apiData)
                    self.arrUsers = userDetails.users
                    print("Total User avilable in thi api\(userDetails.totalUser)")
                } catch {
                    print("passing error")
                }
            } else {
                print("Tame kaik locho karyo")
            }
        }
    }
}
struct UserDetails: Decodable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    private enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "fist_name"
        case lastName = "last_name"
    }
}
struct UserDetailsApiResponse: Decodable{
    var totalPages: Int
    var perPageUser: Int
    var totalUser: Int
    var users: [UserDetails]
    
    private enum CodingKeys: String, CodingKey{
        case totalPages = "total_pages"
        case perPageUsers = "Per_Page"
        case totalUsers = "total"
        case users = "data"
    }
}

