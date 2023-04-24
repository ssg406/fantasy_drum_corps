export enum SocketEvents {
  clientSendsIdentification = 'clientSendsIdentification',
  tourNotFound = 'tourNotFound',
  clientInitiatesDraft = 'clientInitiatesDraft',
  serverInitiatesDraft = 'serverInitiatesDraft',
  draftNotActive = 'draftNotActive',
  serverInitiatesTurn = 'serverInitiatesTurn',
  serverEndsTurn = 'serverEndsTurn',
  clientSendsPick = 'clientSendsPick',
  serverEndsDraft = 'serverEndsDraft',
}
