//
//  UserDetailView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import SwiftUI

struct UserDetailView: View {
    @State var conta: Conta
    @State var contaUser: ContaPrincipal?
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("Detalhes do Usuário")
                        .foregroundColor(Color("textColor"))
                        .bold()
                        .font(.largeTitle)
                }
                ZStack{
                    //Color("backgroundColor")
                VStack{
                    Spacer()
                    ImageView(url: conta.iconUrl)
                        .frame(width: 180, height: 180)
                        .cornerRadius(10.0)
                        .padding()
                    namesView
                    HStack{
                        Spacer()
                            privateView
                        Spacer()
                            verifiedView
                        Spacer()
                    }
                    .padding(.top, 25)
                    Spacer()
                }
                
                }.cornerRadius(10.0)
                .frame(width: 300, height: 450)
                    .border(Color("textColor"), width: 5)
                    .cornerRadius(10.0)
            }

    }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(conta: Conta(id: 12345678654, username: "rafaalt", nomeCompleto: "Rafael Assuncao", isPrivate: true, iconUrl: "https://instagram.fkiv1-1.fna.fbcdn.net/v/t51.2885-19/147115823_933519634144286_1535032367782607406_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fkiv1-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=ZX4I48ejZIIAX86I7Lq&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AT8M0xBCC4rIo7oBP9JIV3uPNtY9hF-8FeU-KBU42FlXeg&oe=62A03F39&_nc_sid=a9513d", isVerified: false))
    }
}
extension UserDetailView{
    var privateView: some View{
        Group{
        if case conta.isPrivate = true{
            VStack{
            Image(systemName: "lock.square.fill")
                .foregroundColor(Color("textColor"))
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
            Text("Private")
                    .foregroundColor(Color.black)
                    .bold()
            }
        }
        else{
            VStack{
            Image("null")
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
            Text("Private")
                    .foregroundColor(Color.gray)
            }
        }
        }
    }
}
extension UserDetailView{
    var verifiedView: some View{
        Group{
        if case conta.isVerified = true{
            VStack{
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .foregroundColor(Color("textColor"))
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
            Text("Verified")
                    .foregroundColor(Color.black)
                    .bold()
            }
        }
        else{
            VStack{
            Image("null")
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
            Text("Verified")
                    .foregroundColor(Color.gray)
            }
        }
        }
    }
}
extension UserDetailView{
    var namesView: some View{
        VStack{
        Text("@\(conta.username)")
            .bold()
            .font(.title)
            .foregroundColor(Color("textColor"))
            .padding(.top, 10)
        Text(conta.nomeCompleto)
            .foregroundColor(Color("textColor2"))
        }
    }
}
