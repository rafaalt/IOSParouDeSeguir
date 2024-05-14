//
//  ImageView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import SwiftUI
import Combine

struct ImageView: View {
    @State var image: UIImage = UIImage()
    @ObservedObject var imageLoader: ImageLoader
    var url: String
    
    init(url: String){
        imageLoader = ImageLoader(url: url)
        self.url = url
    }
    
    
    var body: some View {
            Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "http://cbissn.ibict.br/index.php/imagens/1-galeria-de-imagens-01/detail/3-imagem-3-titulo-com-ate-45-caracteres")
    }
}
class ImageLoader: ObservableObject{
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data(){
        didSet{
            didChange.send(data)
        }
    }
    init(url: String){
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else{return}
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

