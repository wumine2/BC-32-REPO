resource "aws_iam_user_login_profile" "DB-user" {
  count                   = length(var.username)
  user                    = aws_iam_user.eks_user[count.index].name
  password_reset_required = true
  pgp_key                 = "keybase:wumine"
}

resource "aws_iam_user" "eks_user" {
  count         = length(var.username)
  name          = element(var.username, count.index)
  force_destroy = true

  tags = {
    Department = "eks-user"
  }
}
#Developer Group
resource "aws_iam_group" "eks_developer" {
  name = "Developer"
}

#Developer's Policy
resource "aws_iam_group_policy" "developer_policy" {
  name   = "developer"
  group  = aws_iam_group.eks_developer.name
  policy = data.aws_iam_policy_document.developer.json
}

#Developer's Group membership
resource "aws_iam_group_membership" "db_team" {
  name  = "dev-group-membership"
  users = [aws_iam_user.eks_user[0].name]
  group = aws_iam_group.eks_developer.name
}

#Password Policy for users
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

#This is the admin role to be assumed by the manager
resource "aws_iam_role" "managers" {
  name               = "Manager-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.manager_assume_role.json
}

#Policy for the Admin/Manager
resource "aws_iam_policy" "eks_admin" {
  name   = "eks-admin"
  policy = data.aws_iam_policy_document.admin.json
}

#Policy attachment for Manager
resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.managers.name
  policy_arn = aws_iam_policy.eks_admin.arn
}



