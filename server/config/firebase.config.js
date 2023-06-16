const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');

const serviceAccount = require('./simplfi-b126b-firebase-adminsdk-8yhpz-b981b1a464.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();