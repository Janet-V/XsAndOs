//
//  MPPeerView.swift
//  XsAndOs
//
//  Created by Janet Victoria on 10/2/23.
//

import SwiftUI

struct MPPeerView: View {
    @EnvironmentObject var connectionManager: MPConnectionManager
    @EnvironmentObject var game: GameService
    @Binding var startGame: Bool
    var body: some View {
        VStack{
            Text("Available Players")
            List(connectionManager.availablePeers, id: \.self) { peer in
                HStack{
                    Text(peer.displayName)
                    Spacer()
                    Button("Select"){
                        game.gameType = .peer
                        connectionManager.nearbyServiceBrowser.invitePeer(peer, to: connectionManager.session, withContext: nil, timeout: 30)
                        game.player1.name = connectionManager.myPeerId.displayName
                        game.player2.name = peer.displayName
                    }
                    .buttonStyle(.borderedProminent)
                }
                .alert("Received invitation from \(connectionManager.receivedInviteFrom?.displayName ?? "Unknown")", isPresented: $connectionManager.receivedInvite){
                    Button("Accept"){
                        if let invitationHandeler = connectionManager.invitationHandler{
                            invitationHandeler(true,connectionManager.session)
                            game.player1.name = connectionManager.receivedInviteFrom?.displayName ?? "Unknown"
                            game.player2.name = connectionManager.myPeerId.displayName
                            game.gameType = .peer
                        }
                    }
                    Button("Reject"){
                        if let invitationHandler = connectionManager.invitationHandler{
                            invitationHandler(false, nil)
                        }
                    }
                }
            }
        }
        .onAppear{
            connectionManager.isAvailableToPlay = true
            connectionManager.startBrowsing()
        }
        .onDisappear{
            connectionManager.stopBrowsing()
            connectionManager.stopAdvertising()
            connectionManager.isAvailableToPlay = false
        }
        .onChange(of: connectionManager.paired){ newValue in
            startGame = newValue
        }
    }
}

struct MPPeerView_Previews: PreviewProvider {
    static var previews: some View {
        MPPeerView(startGame: .constant(false))
            .environmentObject(MPConnectionManager(yourName: "Sample"))
            .environmentObject(GameService())
    }
}
