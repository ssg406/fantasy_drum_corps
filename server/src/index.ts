import { SocketEvents } from './models/SocketEvents';
import io from './server';
import { toursRepository } from './data';
import Tour from './models/Tour';
import { allPicks } from './allPicks';
import { Socket } from 'socket.io';
import MemberNodeList from './models/MemberNodeList';

// Close pre existing sockets
io.disconnectSockets();

// Register Socket.io listeners
io.on('connection', (socket) => {
  console.log('connected with socket id ', socket.id);
  socket.on(SocketEvents.clientSendsIdentification, async (data) => {
    // Get userId and tourId
    const uid = data.uid;
    const tourId = data.tourId;

    const tour = await toursRepository.findById(tourId);

    if (tour == null) {
      socket.emit(SocketEvents.tourNotFound);
      socket.disconnect;
    }

    socket.emit('foundTour', { message: 'you will be joined to the room now' });
    socket.join(tour.id);
    startDraft(tour, socket);
  });
});

function startDraft(tour: Tour, socket: Socket) {
  let pickIds = generatePickIds();
  let pickOrderList = generatePickOrder(tour.members);
  let currentPicker = pickOrderList.head;
  let roundNumber: number = 0;

  io.to(tour.id).emit('serverSendsStartingPicks', { startingPicks: pickIds });

  // Start the turn and set the turn timer
  io.to(tour.id).emit('draftTurnStart', {
    currentTurn: currentPicker?.userId,
    nextTurn: currentPicker?.next?.userId,
  });

  socket.on('clientSendsPick', (clientPick) => {
    pickIds = pickIds.filter((pick) => pick !== clientPick.pickId);
    roundNumber++;

    // Emit the updated draft state
    io.to(tour.id).emit('draftStateUpdated', {
      availablePicks: pickIds,
      roundNumber,
    });

    // If available picks is empty, end the draft
    if (pickIds.length === 0) {
      io.to(tour.id).emit('draftOver');
    } else {
      // Set the current picker to the next on the list
      currentPicker = currentPicker?.next;
      // Emit a new start turn event with updated pickers
      io.to(tour.id).emit('draftTurnStart', {
        currentTurn: currentPicker,
        nextTurn: currentPicker?.next,
      });
    }
  });

  socket.on('clientTurnTimeOut', () => {
    console.log('clients turn timed out');
    roundNumber++;

    // Emit the updated draft state
    io.to(tour.id).emit('draftStateUpdated', {
      availablePicks: pickIds,
      roundNumber,
    });

    // If available picks is empty, end the draft
    if (pickIds.length === 0) {
      io.to(tour.id).emit('draftOver');
    } else {
      // Set the current picker to the next on the list
      currentPicker = currentPicker?.next;
      // Emit a new start turn event with updated pickers
      io.to(tour.id).emit('draftTurnStart', {
        currentTurn: currentPicker,
        nextTurn: currentPicker?.next,
      });
    }
  });
}

function generatePickOrder(members: string[]): MemberNodeList {
  const memberList = new MemberNodeList();
  for (let i = 0; i < members.length; i++) {
    memberList.addNode(members[i]);
  }
  return memberList;
}

function generatePickIds(): string[] {
  const pickIds: string[] = [];

  for (let i = 0; i < allPicks.length; i++) {
    pickIds.push(allPicks[i].id);
  }

  return pickIds;
}
