import { getRepository } from 'fireorm';
import * as fireorm from 'fireorm';
import Tour from './models/Tour';
import Lineup from './models/Lineup';
import db from './firebase';

fireorm.initialize(db);

export const toursRepository = getRepository(Tour);
export const lineupRepository = getRepository(Lineup);
