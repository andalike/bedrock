variable "profile" {
  description = "Profile"
  type        = string
  default     = "edii-ai-bot-1"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

variable "foundation_models" {
  description = "Foundation Model"
  type        = list(string)
  default     = ["mistral.mistral-7b-instruct-v0:2"]
}

variable "tags" {
  description = "Foundation Model"
  type        = map(string)
  default     = {}
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }
}

resource "aws_iam_role" "bedrock_role" {
  name = "bedrock-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sts:AssumeRole"
        Effect   = "Allow"
        Principal = {
          Service = "bedrock.amazonaws.com"
        }
      }
    ]
  })

}

resource "aws_iam_policy" "bedrock_policy" {
  name        = "bedrock_policy"
  description = "AWS Bedrock Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream",
          "bedrock:ListFoundationalModels",
          "bedrock:GetFoundationalModel",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "bedrock_attachment" {
  name       = "bedrock_attachment"
  roles       = [aws_iam_role.bedrock_role.name]
  policy_arn = aws_iam_policy.bedrock_policy.arn
}

output "bedrock_role_arn" {
  description = "ARN of the IAM role for Bedrock access"
  value       = aws_iam_role.bedrock_role.arn
}

output "bedrock_api_endpoint" {
  description = "AWS Bedrock API endpoint for on-demand inference"
  value       = "https://bedrock-runtime.${var.region}.amazonaws.com/model/${var.foundation_models[0]}/invoke"
}