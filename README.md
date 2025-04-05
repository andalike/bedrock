# AWS Bedrock Terraform Setup and Usage Guide

This repository contains Terraform configurations for setting up AWS Bedrock with the necessary IAM permissions and provides examples for interacting with foundation models.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (v1.0+)
- Python 3.6+ (for running the Python example)
- Boto3 installed (`pip install boto3`)

## Quick Start

### 1. Configuration and Setup

```bash
# Set Variables
AWS_PROFILE=edii-ai-bot-1
REGION=us-east-1

# Verify Models access
aws bedrock list-foundation-models --region $REGION --profile $AWS_PROFILE

# Check specific model availability
aws bedrock get-foundation-model --model-identifier mistral.mistral-7b-instruct-v0:2 --region $REGION --profile $AWS_PROFILE
aws bedrock get-foundation-model --model-identifier amazon.titan-text-express-v1 --region $REGION --profile $AWS_PROFILE
aws bedrock get-foundation-model --model-identifier deepseek.r1-v1:0 --region $REGION --profile $AWS_PROFILE
```

### 2. Deploy Infrastructure

```bash
# Initialize, validate, plan, and apply Terraform configurations
terraform init && terraform validate && terraform plan && terraform apply -auto-approve

# Refresh state and display outputs
terraform refresh
terraform output
```

### 3. Test Model Invocation

```bash
# Test with AWS CLI
aws bedrock-runtime invoke-model \
  --model-id mistral.mistral-7b-instruct-v0:2 \
  --body '{"prompt": "Tell me about AWS Bedrock", "max_tokens": 512}' \
  --cli-binary-format raw-in-base64-out \
  --content-type application/json \
  --region us-east-1 \
  --profile edii-ai-bot-1 \
  output.json
  
# View the response
cat output.json
```

### 4. Cleanup Resources

```bash
# Remove all created resources
terraform destroy -auto-approve
```

## Project Structure

```
.
├── main.tf              # Root configuration file
├── bedrock/             # Bedrock module directory
│   └── main.tf          # Bedrock module configuration
├── .terraform/          # Terraform plugins directory
├── .terraform.lock.hcl  # Terraform dependency lock file
├── terraform.tfstate    # Terraform state file
└── README.md            # This documentation
```

## IAM Permissions

The Terraform configuration creates an IAM role with the following permissions:
- `bedrock:InvokeModel`
- `bedrock:InvokeModelWithResponseStream`
- `bedrock:ListFoundationalModels`
- `bedrock:GetFoundationalModel`

## Python Example

Here's an example of how to invoke AWS Bedrock using Python:

```python
import boto3
import json

# Create a session with the profile
session = boto3.Session(profile_name='edii-ai-bot-1')

# Create a Bedrock Runtime client from the session
bedrock = session.client(
    service_name='bedrock-runtime',
    region_name='us-east-1'
)

# Prepare the prompt
request_body = {
    "prompt": "Tell me about AWS Bedrock",
    "max_tokens": 512
}

# Invoke the model
response = bedrock.invoke_model(
    modelId='mistral.mistral-7b-instruct-v0:2',
    body=json.dumps(request_body)
)

# Parse and print the response
response_body = json.loads(response['body'].read())
print(response_body)
```

## Troubleshooting

- **No outputs found**: Ensure that your module has output definitions and they are properly referenced in the root module.
- **Access denied**: Verify that your AWS profile has the necessary permissions to create IAM roles and access Bedrock services.
- **Invalid base64**: When using the AWS CLI, include the `--cli-binary-format raw-in-base64-out` flag.

## Resources

- [AWS Bedrock Documentation](https://docs.aws.amazon.com/bedrock/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws)
- [Boto3 Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)