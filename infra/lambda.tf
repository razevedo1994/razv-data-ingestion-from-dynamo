data "archive_file" "lambda" {
  type          = "zip"
  source_file   = "../code/handler.py"
  output_path   = "./lambda_layer/lambda_payload.zip"
}

resource "aws_lambda_function" "live_lambda_example" {
  filename      = "./lambda_layer/lambda_function_payload.zip"
  function_name = "${var.lambda_name}-${var.env}"
  handler       = "handler.lambda_handler"
  role          = aws_iam_role.role.arn

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

  depends_on = [ 
    aws_iam_role_policy_attachment.attach
   ]

  vpc_config {
    subnet_ids            = [aws_subnet.this.id]
    security_group_ids  = [aws_security_group.this.id] 
  }

  tags = {
    env             = var.env
    project_name    = var.project_prefix
  } 
}