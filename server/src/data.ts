import {getRepository} from 'fireorm';
import * as fireorm from 'fireorm';
import Tour from './models/Tour';
import db from './firebase';

fireorm.initialize(db);

export const toursRepository = getRepository(Tour);

