importScripts('https://www.gstatic.com/firebasejs/10.8.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.8.1/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyAbctx-1rArQxLRxih2oZgnC_5v0wdPhqQ",
  authDomain: "pizzasprintnotification.firebaseapp.com",
  projectId: "pizzasprintnotification",
  storageBucket: "pizzasprintnotification.firebasestorage.app",
  messagingSenderId: "412279854118",
  appId: "1:412279854118:android:a40f18e02f5443142202e7"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
  console.log("Received background message: ", payload);
  self.registration.showNotification(payload.notification.title, {
    body: payload.notification.body,
    icon: "/icons/Icon-192.png",
  });
});
