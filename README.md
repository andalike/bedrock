# Set Variables
AWS_PROFILE=edii-ai-bot-1
REGION=us-east-1

# Verify Models access
aws bedrock list-foundation-models --region $REGION --profile $AWS_PROFILE
aws bedrock get-foundation-model --model-identifier amazon.titan-text-express-v1 --region $REGION --profile $AWS_PROFILE
aws bedrock get-foundation-model --model-identifier deepseek.r1-v1:0 --region $REGION --profile $AWS_PROFILE
aws bedrock get-foundation-model --model-identifier mistral.mistral-7b-instruct-v0:2 --region $REGION --profile $AWS_PROFILE

## Running the file
terraform init && terraform validate && terraform plan && terraform apply -auto-approve
terraform refresh
terraform output

## Deleting 
terraform destroy -auto-approve


## Test with CLI
aws bedrock-runtime invoke-model \
  --model-id mistral.mistral-7b-instruct-v0:2 \
  --body '{"prompt": "Tell me about AWS Bedrock", "max_tokens": 512}' \
  --cli-binary-format raw-in-base64-out \
  --content-type application/json \
  --region us-east-1 \
  --profile edii-ai-bot-1 \
  output.json
 

 -- This creates a file output.json with the response