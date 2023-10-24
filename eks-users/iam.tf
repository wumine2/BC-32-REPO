#Permissions for Developer1/Developer Group
data "aws_iam_policy_document" "developer" {
  statement {
    sid    = "AllowDeveloper"
    effect = "Allow"
    actions = [
      "eks:DescribeCluster",
      "eks:ListNodegroups",
      "eks:DescribeNodegroup",
      "eks:ListClusters",
      "eks:AccessKubernetesApi",
      "eks:ListUpdates",
      "eks:ListFargateProfiles",
      "ssm:GetParameter"
    ]
    resources = ["*"]
  }
}

#Permissions for Manager user who is the Admin (Admin Group)
data "aws_iam_policy_document" "admin" {
  statement {
    sid       = "AllowAdmin"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com"]
    }
  }
}


#Permission for the manager-eks-role. For the manager to be able to assume this role; therefore the manager is the Principal
data "aws_iam_policy_document" "manager_assume_role" {
  statement {
    sid    = "AllowManagerAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/manager"]
      #identifiers = ["data.aws_caller_identity.current.account_id]}
    }
  }
}

data "aws_caller_identity" "current" {}






