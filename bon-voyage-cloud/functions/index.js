const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

//const db = admin.firestore()
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
exports.deleteUser = functions.https.onRequest((req, res) => {
  const { email } = req.body;

  auth
    .getUserByEmail(email)
    .then(({ uid }) => {
      return auth.deleteUser(uid);
    })
    .then(() => {
      res.status(200).send("User susccesfully deleted!");
    })
    .catch((error) => {
      console.log(error);
      res.status(500).send(error);
    });
});

// OnCreate
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

// On Update
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

// On Delete
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
