import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToTopic = functions.firestore
    .document('sheetList/{sheetListId}')
    .onCreate(async snapshot =>{
        const sheet = snapshot.data();
        const payload: admin.messaging.MessagingPayload  ={
            notification:{
                title: 'New Sheet!',
                body: `${sheet['sheetName']}is ready for you`,
            }
        }
        return fcm.sendToTopic('sheet',payload);
    });

    