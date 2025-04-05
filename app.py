import boto3
import json

session = boto3.Session(profile_name='edii-ai-bot-1')

bedrock = session.client(
    service_name='bedrock-runtime',
    region_name='us-east-1'
)

request_body = {
    "prompt": "Why is the sky blue?",
    "max_tokens": 512
}

response = bedrock.invoke_model(
    modelId='mistral.mistral-7b-instruct-v0:2',
    body=json.dumps(request_body)
)

response_body = json.loads(response['body'].read())
print(response_body)