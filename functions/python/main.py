
from firebase_functions import https_fn
from firebase_admin import initialize_app, firestore

initialize_app()

db = firestore.client()

@https_fn.on_call()
def request_example(data, context):

    
    docs = db.collection('profiles').limit(1).get()
    id = docs[0].id
    db.collection('profiles').document(id).update({"counter": firestore.Increment(1)})

    return docs[0]._data["firstName"]
