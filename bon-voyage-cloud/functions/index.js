const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")(functions.config().stripe.secret);

admin.initializeApp();

const db = admin.firestore();
//const storage = admin.storage().bucket()
const auth = admin.auth();

// Hello World Function
exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  functions.database.ref("users");
  response.send("Hello from Firebase!");
});

// Delete User - on http request
// Use from postman to delete registered test user
exports.deleteUser = functions.https.onRequest(async (req, res) => {
  const { email } = req.body;

  const user = await auth.getUserByEmail(email).catch((error) => {
    console.log(error);
    res.status(500).send({ message: "Unable to find user!" });
  });

  auth
    .deleteUser(user.uid)
    .then(() => {
      res.status(200).send("User susccesfully deleted!");
    })
    .catch((error) => {
      console.log(error);
      res.status(500).send(error);
    });
});

// Vacation added - on create vacation in firestore
exports.vacationAdded = functions.firestore
  .document("vacations/{vacationId}")
  .onCreate((snap) => {
    // Any time a document is created in the 'vacations' collection, this function will be called.

    // The firestore document data in a JSON object.
    const data = snap.data();

    functions.logger.log("New Vacation: ", data);

    // Do what you need to do with this data.

    return null;
  });

// Vacation updated - on vacation update in firestore
exports.vacationUpdated = functions.firestore
  .document("vacations/{vacationId}")
  .onUpdate((change) => {
    // Any time a document is updated in the 'vacations' collection, this function will be called.

    // The firestore document object BEFORE.
    const beforeData = change.before.data();

    // The firestore document object NOW.
    const data = change.after.data();

    functions.logger.log("Old Vacation: ", beforeData);
    functions.logger.log("New Vacation: ", data);

    // Do what you need to do with this data.

    return null;
  });

// Vacation deleted - on vacation deleted
exports.vacationDeleted = functions.firestore
  .document("vacations/{vacationId}")
  .onDelete((snap) => {
    // Any time a document is deleted in the 'vacations' collection, this function will be called.

    // The firestore document that was just deleted.
    const data = snap.data();

    functions.logger.log("Deleted Vacation: ", data);

    // Do what you need to do with this data.

    return null;
  });

// Create Stripe User object on Firebase auth register user
// Function to be called from the app, alternative to createStripeUserObject
exports.createStripeUser = functions.https.onCall(async (data, context) => {
  // data - we pass to the function
  const email = data.email;

  //context - who is making the call
  const uid = context.auth.uid;

  if (uid === null) {
    console.log("Illegal access attempt due to unauthenticated attempt.");
    throw new functions.https.HttpsError("internal", "Illegal access attempt");
  }

  return stripe.customers
    .create({ email: email })
    .then((customer) => {
      return customer["id"];
    })
    .then((customerId) => {
      admin.firestore().collection("users").doc(uid).set({
        stripeId: customerId,
        email: email,
        id: uid
      });
    })
    .catch((err) => {
      console.log(err);
      throw new functions.https.HttpsError(
        "internal",
        " Unable to create Stripe user : " + err
      );
    });
});

exports.createStripeUserObject = functions.auth
  .user()
  .onCreate(({ uid, email, photoURL }) => {
    if (!uid || !email) {
      console.log("Illegal access attempt due to unauthenticated attempt.");
      throw new functions.https.HttpsError(
        "internal",
        "Illegal access attempt"
      );
    }

    photoURL =
      photoURL ||
      "https://icon-library.com/images/icon-avatar/icon-avatar-0.jpg";

    return stripe.customers
      .create({ email: email })
      .then(({ id }) => {
        admin.firestore().collection("users").doc(uid).set({
          stripeId: id,
          email: email,
          id: uid,
          photoURL
        });
      })
      .catch((err) => {
        console.log(err);
        throw new functions.https.HttpsError(
          "internal",
          " Unable to create Stripe user : " + err
        );
      });
  });

// const user = {
//   phoneNumber: null,
//   email: "dari@test.com",
//   photoURL: null,
//   uid: "QDTAzlhMUyNfMrhosEbnmo0sdno1",
//   passwordSalt: null,
//   emailVerified: false,
//   disabled: false,
//   metadata: {
//     lastSignInTime: "2022-01-15T19:34:43Z",
//     creationTime: "2022-01-15T19:34:43Z"
//   },
//   customClaims: {},
//   providerData: [
//     { providerId: "password", uid: "dari@test.com", email: "dari@test.com" }
//   ],
//   passwordHash: null,
//   tokensValidAfterTime: null,
//   displayName: null
// };
