# resource "aws_cloudwatch_event_rule" "main" {
#   description = "Every 5 minutes"
#   schedule_expression = "rate(5 minutes)"
#   is_enabled = false
# }

# resource "aws_cloudwatch_event_target" "main" {
#   rule = aws_cloudwatch_event_rule.main.name
#   arn = aws_lambda_function.main.arn
# }
