# resource "aws_lambda_function" "main" {
#   function_name = "aws_price_notify"
#   role = aws_iam_role.main.arn

#   package_type = "Image"
#   image_uri = "${aws_ecr_repository.main.repository_url}:latest"

#   timeout = 30

#   environment {
#     variables = {
#       SLACK_WEBHOOK_URL = "https://hooks.slack.com/services/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"
#     }
#   }
# }

# resource "aws_lambda_permission" "allow_cloudwatch" {
#   action = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.main.function_name
#   principal = "events.amazonaws.com"
#   source_arn = aws_cloudwatch_event_rule.main.arn
# }
