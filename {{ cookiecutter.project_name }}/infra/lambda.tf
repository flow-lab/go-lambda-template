resource "aws_iam_role" "role" {
  name = "${var.name}-${data.aws_region.current.name}-role"

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

  tracing_config {
    mode = "Active"
  }

  depends_on = [
    aws_iam_role_policy_attachment.logs,
    aws_iam_role_policy_attachment.sqs,
    aws_iam_role_policy_attachment.xray,
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

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.logs.arn
}

resource "aws_iam_policy" "xray" {
  name        = "xray"
  path        = "/"
  description = "IAM policy for xray for lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "xray:PutTraceSegments"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "xray" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.xray.arn
}

resource "aws_iam_policy" "sqs" {
  name        = "sqs"
  path        = "/"
  description = "IAM policy for consuming sqs by lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:ChangeMessageVisibility",
        "sqs:GetQueueAttributes"
      ],
      "Resource": "${aws_sqs_queue.queue.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "sqs" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.sqs.arn
}

resource "aws_iam_policy" "kms" {
  name        = "kms"
  path        = "/"
  description = "IAM policy for decrypting messages"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": "${aws_kms_key.key.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kms" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.kms.arn
}

resource "aws_lambda_event_source_mapping" "sqs" {
  event_source_arn = aws_sqs_queue.queue.arn
  function_name    = aws_lambda_function.lambda.arn
}