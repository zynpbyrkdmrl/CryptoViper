//
//  Router.swift
//  CryptoViper
//
//  Created by Zeynep Bayrak Demirel on 28.07.2023.
//

import Foundation
import UIKit

// class, protocol
// entryPoint - uygulama ilk açıldıgında hangi view görünecek falan gibi soruların cevabını burada vermemiz gerekiyor.

typealias EntryPoint = AnyView & UIViewController //Entrypoint gördügün her yer aslında bu demek.
protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    //diğer dosyalardan da ulaşılabilsin diye static diyoruz.
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter { // burda bütün her şeyi birbirine bağlayıp çalıştırmamız lazım.
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
}
