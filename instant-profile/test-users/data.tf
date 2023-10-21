data "aws_iam_users" "users" {
}

output "arn" {
  value = data.aws_iam_users.users.arns
}

output "usernames" {
  value = data.aws_iam_users.users.names
}


resource "aws_iam_group_membership" "db_team" {
  name  = "dev-groupmembership"
  users = data.aws_iam_users.users.names
  group = "Dev"
}