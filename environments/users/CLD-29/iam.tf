
#CLD 29 SECTION

data "aws_iam_policy_document" "masters" {
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


#Permission for the master-eks-role. For the manager to be able to assume this role; therefore the masters is the Principal
data "aws_iam_policy_document" "masters_assume_role" {
  statement {
    sid    = "AllowAccountAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id] #any entity or user or group in this account can assume the role. My account is the principal
      #identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/manager"]
    }
  }
}

data "aws_iam_policy_document" "masters_role" {
  statement {
    sid       = "AllowMastersAssumeRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Masters-eks-Role"]
  }
}



data "aws_caller_identity" "current" {}