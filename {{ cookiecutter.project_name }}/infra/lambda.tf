resource "aws_iam_role" "role" {
  name = "${var.name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda" {
  function_name = var.name
  role          = aws_iam_role.role.arn
  handler       = "lambda"

  filename         = "../deployment.zip"
  source_code_hash = filebase64sha256("../deployment.zip")

  runtime = "go1.x"

  depends_on = [
    aws_iam_role_policy_attachment.attachment
  ]
}

resource "aws_iam_policy" "logs" {
  name        = "logs"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.logs.arn
}