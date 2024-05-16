
import unittest
from unittest.mock import patch
from google.cloud import firestore
from google.auth import credentials
from datetime import datetime, timedelta


import os

PROJECT_ID = "deep-connections-7796d" # can be changed so that firestore data is stored in a different database

os.environ["GCLOUD_PROJECT"] = "deep-connections-7796d" # don't change
os.environ["FIRESTORE_EMULATOR_HOST"] = "localhost:8080"

db = firestore.Client(project=PROJECT_ID, credentials=credentials.AnonymousCredentials())

# stub all firebase_admin functions. Replace firestore db with local emulator
with patch('firebase_admin.initialize_app'), \
patch('firebase_functions.https_fn.on_call', lambda: lambda f: f), \
    patch('firebase_admin.firestore.client', lambda: db):  
    from main import request_example

UID = "testUserId"
data = {}
context = {
    "auth": {
        "uid": UID,
    },
}

class TestCloudFunctions(unittest.TestCase):

    def setUp(self):
        self.clear_firestore()

    def clear_firestore(self):
        collections = db.collections()
        for collection in collections:
            docs = collection.stream()
            for doc in docs:
                doc.reference.delete()

    def test_request_example(self):

        data = {
            'firstName': 'Bob',
            'serverTimestamp': firestore.SERVER_TIMESTAMP,
            'yesterdayTimestamp': datetime.now() - timedelta(days=1)
        }
        db.collection("profiles").add(data)
        response = request_example(data, context)
        print(response)
        self.assertEqual(response, 'Bob')
