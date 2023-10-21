# The resources in this section is for Ticket CLD-29.
# create an IAM role that can be assumed by users in the Masters Group
# the role needs to have administrator permissions in AWS
# add multiple users to the Masters group
# test to ensure that each user added has admin access to the EKS Cluster
# AC: An admin role created and assumable by users in the Masters Group

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

resource "aws_iam_group" "eks_masters" {
  name = "Masters"
}


resource "aws_iam_group_policy" "masters_policy" {
  name   = "masters"
  group  = aws_iam_group.eks_masters.name
  policy = data.aws_iam_policy_document.masters_role.json
}


resource "aws_iam_group_membership" "masters_team" {
  name  = "masters-group-membership"
  users = [ aws_iam_user.eks_user[1].name, aws_iam_user.eks_user[2].name ]
  group = aws_iam_group.eks_masters.name
}

#This is the Admin role to be assumed by the Group Masters
resource "aws_iam_role" "masters" {
  name               = "Masters-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.masters_assume_role.json
}


resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.masters.name
  policy_arn = aws_iam_policy.eks_admin.arn
}


resource "aws_iam_policy" "eks_admin" {
  name   = "eks-masters"
  policy = data.aws_iam_policy_document.masters.json
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