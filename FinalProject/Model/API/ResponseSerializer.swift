//
//  ResponseSerializer.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Request {
    static func responseJSONSerializer(log: Bool = true,
                                       response: HTTPURLResponse?,
                                       data: Data?,
                                       error: Error?) -> Result<Any> {
        guard let response = response else {
            if let error = error {
                let errorCode = error.code
                if abs(errorCode) == Api.Error.cancelRequest.code { // code is 999 or -999
                    return .failure(Api.Error.cancelRequest)
                }
                return .failure(error)
            }
            return .failure(Api.Error.noResponse)
        }

        let statusCode = response.statusCode

        if let error = error {
            return .failure(error)
        }

        if 204...205 ~= statusCode { // empty data status code
            return .success([:])
        }

        guard 200...299 ~= statusCode else {
            if statusCode == Api.Error.cancelRequest.code {
                return .failure(Api.Error.cancelRequest)
            }
            var err: NSError!
            if let json = data?.toJSON() as? JSObject,
                let reason = json["reason"] as? String {
                err = NSError(code: statusCode, message: reason)
            } else if let status = HTTPStatus(code: statusCode) {
                err = NSError(domain: Api.Path.baseURL.host, status: status)
            } else {
                err = NSError(domain: Api.Path.baseURL.host,
                              code: statusCode,
                              message: "Mã HTTP không xác định (\(statusCode)).")
            }
            #if DEBUG
            print("------------------------")
            print("Request: \(String(describing: response.url))")
            print("Error: \(err.code) - \(err.localizedDescription)")
            #endif
            return .failure(err)
        }

        if statusCode == 204 {
            return .success([:])
        }

        guard let data = data, let json = data.toJSON() else {
            return Result.failure(Api.Error.json)
        }

        return .success(json)
    }
}

extension DataRequest {
    static func responseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { _, response, data, error in
            return Request.responseJSONSerializer(log: true,
                                                  response: response,
                                                  data: data,
                                                  error: error)
        }
    }

    @discardableResult
    func responseJSON(queue: DispatchQueue = .global(qos: .background),
                      completion: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataRequest.responseSerializer(),
                        completionHandler: completion)
    }
}
