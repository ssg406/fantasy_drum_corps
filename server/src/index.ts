import SocketEvents from './models/SocketEvents';
import io from './server';
import { toursRepository } from './data';

// Register Socket.io listeners
io.on('connection', (socket) => {
  console.log('connected with socket id ', socket.id);
  socket.on(SocketEvents.onIdentifyClient, async (data) => {

    // Get userId and tourId
    const uid = data.uid;
    const tourId = data.tourId;

    const tour = await toursRepository.findById(tourId);

    if (tour == null) {
      socket.emit(SocketEvents.tourNotFound);
    }
    console.log(`Found tour ${tour.name}. Checing if user is tour admin.`);
    if (tour.owner === uid) {
      socket.on(SocketEvents.initiateDraft, () => {
        // Write to draftActive field of tour
        // Set countdown here
        socket.join(tour.id);
      })
    }

    if (tour.draftActive === true) {
      socket.join(tour.id);
    } else {
      socket.emit(SocketEvents.draftNotActive);
    }
  
  })
})

