provider "aws" {
  profile = "edii-ai-bot-1"
  region  = "us-east-1"
}

module "bedrock" {
  source            = "./bedrock"
  region            = "us-east-1"
  profile           = "edii-ai-bot-1"
  foundation_models = ["mistral.mistral-7b-instruct-v0:2"]
  tags = {
    Environment = "prod"
    Project     = "AI-Service"
    User        = "Ankit"
  }
}

output "bedrock_role_arn" {
  description = "ARN of the IAM role for Bedrock access"
  value       = module.bedrock.bedrock_role_arn
}

output "bedrock_api_endpoint" {
  description = "AWS Bedrock API endpoint for on-demand inference"
  value       = module.bedrock.bedrock_api_endpoint
}