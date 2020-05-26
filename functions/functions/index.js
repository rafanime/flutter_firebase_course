const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.createAccount = functions.auth.user().onCreate(user => {

  admin.firestore().collection('user').doc(user.uid).set({
    email: user.email,
  });
});