//
//  PicturesService.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import Foundation

struct PicturesService {

    let dataTask = BaseNetworkTask<EmptyModel, [PictureResponseModel]>(
         isNeedInjectToken: true,
         method: .get,
         path: "picture/"
     )

    func loadPictures(_ onResponseWasReceived: @escaping (_ result: Result<[PictureResponseModel], Error>) -> Void) {
         dataTask.performRequest(onResponseWasReceived)
     }

 }
