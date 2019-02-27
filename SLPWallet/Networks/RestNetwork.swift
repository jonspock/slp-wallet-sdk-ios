//
//  Network.swift
//  SLPWallet
//
//  Created by Jean-Baptiste Dominguez on 2019/02/26.
//  Copyright © 2019 Bitcoin.com. All rights reserved.
//

import Moya

enum RestNetwork {
    case fetchUTXOs(String)
    case fetchTxs(String)
    case fetchTxDetails(String)
    case broadcast(String)
}

extension RestNetwork: TargetType {
    public var baseURL: URL {
        return URL(string: "https://rest.bitcoin.com/v2")!
    }
    
    public var path: String {
        switch self {
        case .fetchUTXOs(let address):
            return "/address/utxo/\(address)"
        case .fetchTxDetails:
            return "/transaction/details/"
        case .fetchTxs(let address):
            return "/addrs/\(address)"
        case .broadcast: return "/tx/send"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchUTXOs: return .get
        case .fetchTxs: return .get
        case .fetchTxDetails: return .post
        case .broadcast: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .broadcast(let rawTx):
            let str = "{\"rawtx\":\"\(rawTx)\"}"
            if let data = str.data(using: .utf8) {
                return .requestData(data)
            }
            return .requestPlain
        case .fetchTxDetails(let txids):
            let str = "{\"txids\":[\"\(txids)\"]}"
            if let data = str.data(using: .utf8) {
                return .requestData(data)
            }
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}