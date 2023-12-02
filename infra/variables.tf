variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "lambda_name" {
    type = string
    default = "ingest_fake_logs"
}

variable "env" {
    type = string
    default = "dev"
}

variable "project_prefix" {
    type = string
    default = "dynamodb-stream"
}