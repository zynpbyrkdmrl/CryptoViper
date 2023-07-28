//
//  Presenter.swift
//  CryptoViper
//
//  Created by Zeynep Bayrak Demirel on 28.07.2023.
//

import Foundation

// class, protocol
// talks to -> interactor, router, view

enum NetworkError : Error {
    case NetworkFailed // datayı indiremedim bile
    case PrasingFailed // datayı indirdim yanlış parse ediyorum
}

protocol AnyPresenter {
    
    var router: AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto (result: Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{ //burdaki değer atanınca yapılacak işlemler.
            interactor?.downloadCryptos()
        }
    }
    
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        //viewa kendini güncelle demem lazım.
        switch result {
        case.success(let cryptos):
            view?.update(with: cryptos)
            
        case.failure(_):
            view?.update(with: "Try again later...")
        }
    }
    
    
    
}
