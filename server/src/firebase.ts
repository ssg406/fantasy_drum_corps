import admin from 'firebase-admin';
import firebaseAccountCredentials from './serviceAccountKey.json';
import { initializeApp } from 'firebase-admin/app';

// Initialize Firebase admin
const serviceAccount = firebaseAccountCredentials as admin.ServiceAccount;
initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const db = admin.firestore();

export default db;
