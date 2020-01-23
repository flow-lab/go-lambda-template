// uncomment me if oyu need to subscribe to sns
//data "aws_sns_topic" "sns" {
//  name = "test"
//}
//
//resource "aws_sns_topic_subscription" "sns" {
//  topic_arn = data.aws_sns_topic.sns.arn
//  protocol  = "sqs"
//  endpoint  = aws_sqs_queue.queue.arn
//}
//
//resource "aws_sqs_queue_policy" "test" {
//  queue_url = aws_sqs_queue.queue.id
//
//  policy = <<POLICY
//{
//  "Version": "2012-10-17",
//  "Id": "sqspolicy",
//  "Statement": [
//    {
//      "Sid": "First",
//      "Effect": "Allow",
//      "Principal": "*",
//      "Action": "sqs:SendMessage",
//      "Resource": "${aws_sqs_queue.queue.arn}",
//      "Condition": {
//        "ArnEquals": {
//          "aws:SourceArn": "${data.aws_sns_topic.sns.arn}"
//        }
//      }
//    }
//  ]
//}
//POLICY
//}

resource "aws_sqs_queue" "queue" {
  name                              = "${var.name}-in"
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
}