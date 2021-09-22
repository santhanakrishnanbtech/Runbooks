```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*",
                "sns:*"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Deny",
            "Action": [
                "cloudtrail:*",
                "iam:AttachUserPolicy",
                "iam:CreateUser",
                "iam:DeleteUser",
                "iam:DeleteUserPolicy",
                "iam:DetachUserPolicy",
                "iam:GetUser",
                "iam:GetUserPolicy",
                "iam:ListAttachedUserPolicies",
                "iam:ListUserPolicies",
                "iam:ListUsers",
                "iam:ListGroups",
                "iam:PutUserPolicy",
                "iam:UpdateUser",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:DetachRolePolicy",
                "iam:DeleteRole",
                "iam:PutRolePolicy",
                "iam:ListPolicies",
                "iam:GetPolicyVersion",
                "iam:GetPolicy",
                "iam:ListPolicyVersions",
                "iam:ListAttachedRolePolicies",
                "iam:GenerateServiceLastAccessedDetails",
                "iam:ListEntitiesForPolicy",
                "iam:ListPoliciesGrantingServiceAccess",
                "iam:ListRoles",
                "iam:GetServiceLastAccessedDetails",
                "iam:ListAccountAliases",
                "iam:ListRolePolicies",
                "iam:UpdateRole",
                "iam:UpdateRoleDescription"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```
