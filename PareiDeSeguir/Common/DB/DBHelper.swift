//
//  DBHelper.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 04/07/22.
//

import Foundation
import SQLite3

class DBHelper{
    
    var dbSeguidores: OpaquePointer?
    var dbParou: OpaquePointer?
    var path1: String = "dbSeguidores4.sqlite"
    var path2: String = "dbParou.sqlite"
    
    init () {
        self.dbSeguidores = createDBSeguidores()
        self.dbParou = createDBParou()
    }
    
    func createDBSeguidores() -> OpaquePointer?{
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathExtension(path1)
        
        var db : OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("Erro na criacao do Banco de Dados")
            return nil
        }else{
            print("Banco criado com sucesso! \(path1)")
            return db
        }
    }
    
    func createDBParou() -> OpaquePointer?{
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathExtension(path2)
        
        var db : OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("Erro na criacao do Banco de Dados")
            return nil
        }else{
            print("Banco criado com sucesso! \(path2)")
            return db
        }
    }
    
    func createTableSeguidores(username: String){
        self.createTable(username: username, db: self.dbSeguidores)
    }
    func createTableParou(username: String){
        self.createTable(username: username, db: self.dbParou)
    }
    
    func createTable(username: String, db: OpaquePointer?){
        let query = "CREATE TABLE IF NOT EXISTS \(username) ( id TEXT PRIMARY KEY, username TEXT, nomecompleto TEXT, isverified INTEGER, isprivate INTEGER, iconurl TEXT );"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &createTable, nil) == SQLITE_OK{
            if(sqlite3_step(createTable) == SQLITE_DONE){
                print("Tabela \(username) criada com sucesso")
            }else{
                print("Erro na criacao da tabela \(username)!")
            }
        }else{
            print("Erro na preparacao")
        }
        sqlite3_finalize(createTable)
    }
    
    func inserirSeguidor(table: String, conta: Conta){
        self.inserir(table: table, conta: conta, db: self.dbSeguidores)
    }
    func inserirSeguidorParou(table: String, conta: Conta){
        self.inserir(table: table, conta: conta, db: self.dbParou)
    }
    
    func inserir(table: String, conta: Conta, db: OpaquePointer?){
        let query = "INSERT INTO \(table) (id, username, nomecompleto, isverified, isprivate, iconurl) VALUES (?, ?, ?, ?, ?, ?)"
        
        let idConta = "\(conta.id)"
        var verificado = 0
        var privado = 0
        if(conta.isVerified){
            verificado = 1
        }
        if(conta.isPrivate){
            privado = 1
        }
        var inserido: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &inserido, nil) == SQLITE_OK{
            sqlite3_bind_text(inserido, 1, (idConta as NSString).utf8String, -1, nil)
            sqlite3_bind_text(inserido, 2, (conta.username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(inserido, 3, (conta.nomeCompleto as NSString).utf8String, -1, nil)
            sqlite3_bind_int(inserido, 4, Int32(verificado))
            sqlite3_bind_int(inserido, 5, Int32(privado))
            sqlite3_bind_text(inserido, 6, (conta.iconUrl as NSString).utf8String, -1, nil)
            
            if(sqlite3_step(inserido) == SQLITE_DONE){
                print("Seguidor inserido com sucesso")
            }else{
                print("Erro na insercao")
            }
        }else{
            print("Query nao ta pronto pra insercao")
        }
        
        sqlite3_finalize(inserido)
    }
    
    func lerSeguidores(table: String) -> [Conta]{
        return lerDB(table: table, db: self.dbSeguidores)
    }
    func lerParou(table: String) -> [Conta]{
        return lerDB(table: table, db: self.dbParou)
    }
    
    func lerDB(table: String, db: OpaquePointer?) -> [Conta]{
        var seguidores: [Conta] = []
        let query = "SELECT * FROM \(table)"
        
        var busca : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &busca, nil) == SQLITE_OK{
            while(sqlite3_step(busca) == SQLITE_ROW){
                let id = String(cString: sqlite3_column_text(busca, 0))
                let username = String(cString: sqlite3_column_text(busca, 1))
                let nome = String(cString: sqlite3_column_text(busca, 2))
                let verificado = Int(sqlite3_column_int(busca, 3))
                let privado = Int(sqlite3_column_int(busca, 4))
                let iconUrl = String(cString: sqlite3_column_text(busca, 5))
                
                var isPrivate = true
                var isVerified = false
                
                if(privado == 0){
                    isPrivate = false
                }
                if(verificado == 1){
                    isVerified = true
                }

                let conta = Conta(id: Int64(id) ?? 0, username: username, nomeCompleto: nome, isPrivate: isPrivate, iconUrl: iconUrl, isVerified: isVerified)
                seguidores.append(conta)
            }
        }else{
            print("Erro na preparacao")
        }
        sqlite3_finalize(busca)
        return seguidores
    }
    
    func deleteTable(table: String){
        let query = "DROP TABLE \(table)"
        
        var deletado : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.dbSeguidores, query, -1, &deletado, nil) == SQLITE_OK{
            if(sqlite3_step(deletado) == SQLITE_DONE){
                print("Tabela \(table) removida com sucesso")
            }else{
                print("Erro na removacao da tabela \(table)!")
            }
        }else{
            print("Erro na removao")
        }
        sqlite3_finalize(deletado)
    }
    func removerUserParou(conta: Conta, username: String){
        let query = "DELETE FROM \(username) WHERE id = \(conta.id);"
        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbParou, query, -1, &deleteStatement, nil) ==
              SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
              print("Removido com sucesso.")
            } else {
              print("Nao foi possivel remover.")
            }
          } else {
            print("\nDELETE nao esta preparado")
          }
          
          sqlite3_finalize(deleteStatement)
    }
}
