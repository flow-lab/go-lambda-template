data "aws_iam_policy_document" "sqs_key_policy" {
  policy_id = "sqs-sns-key"

  statement {
    actions = [
      "kms:*"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]

    }

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]

    principals {
      type = "Service"
      identifiers = [
        "sns.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
  }
}

resource aws_kms_key "key" {
  description = "This key is used for encryption of SQS queue"
  policy      = data.aws_iam_policy_document.sqs_key_policy.json
}