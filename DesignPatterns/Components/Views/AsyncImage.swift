//
//  Untitled.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import UIKit

final class AsyncImage: UIImageView {
    var currentWorkItem: DispatchWorkItem?

    // Sobrecarga de métodos, para el mismo método puedo hacer difetentes parametrizaciones
    func setImage(_ image: String) {
        print(">>> Setting image from URL: \(image)")
        if let url = URL(string: image) {
            self.setImage(url)
        } else {
            print(">>> Invalid URL: \(image)")
        }
    }
    
    func setImage(_ image: URL) {
        cancel()
        // Vaciar la propia imagen para no mostrar un elemento por encima
        self.image = UIImage()
        let workItem = DispatchWorkItem {
            let image = (try? Data(contentsOf: image)).flatMap { UIImage(data: $0) } // Casteo(flatMap, porque devuelve un opcional) Si la opcion de la izquierda no es nula transforma
            DispatchQueue.main.async { [weak self] in
                self?.image = image ?? UIImage()
                self?.currentWorkItem = nil
            }
        }
        DispatchQueue.global().async(execute: workItem)
        currentWorkItem = workItem
    }
    
    func cancel() {
        currentWorkItem?.cancel()
        currentWorkItem = nil
    }
}
