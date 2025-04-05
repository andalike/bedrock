AWS_PROFILE=edii-ai-bot-1
REGION=us-east-1

aws bedrock list-foundation-models --region $REGION --profile $AWS_PROFILE
aws bedrock get-foundation-model --model-identifier mistral.mistral-7b-instruct-v0:2 --region $REGION --profile $AWS_PROFILE

aws bedrock get-foundation-model --model-identifier amazon.titan-text-express-v1 --region $REGION --profile $AWS_PROFILE
