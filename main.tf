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
