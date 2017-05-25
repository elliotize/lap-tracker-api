from __future__ import print_function

import json
import urllib
import boto3
import requests

print('Loading function')

url = 'example.com'

def recognize_face(source_image_name):
    collection_name = 'LapTracker'
    bucket='kaushik-test-24'

    client = boto3.client('rekognition')

    response = client.search_faces_by_image(
        CollectionId=collection_name,
        Image={
            'S3Object': {
                'Bucket': bucket,
                'Name': source_image_name
            }
        },
        MaxFaces=1,
        FaceMatchThreshold=85
    )

    if len(response['FaceMatches'])==0:
        print("not matched")
        face_id="NotFound"
    else:
        print(response['FaceMatches'][0]['Similarity'])
        face_id=response['FaceMatches'][0]['Face']['FaceId']
    return face_id

def send_event(data):
    headers = {'Authorization': 'Bearer ' + token, "Content-Type": "application/json"}
    response = requests.put(url, data=json.dumps(data), headers=headers)

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    image_name='KaushikSirineni.jpg'
    location = 'A'
    time = '123456456'

    face_id = recognize_face(image_name)

    body = {"face": face_id, "location": location, "time": time}
    #send_event(body)
    return body

