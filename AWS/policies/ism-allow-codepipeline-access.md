```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:PassRole",
                "iam:AttachRolePolicy"
            ],
            "Resource": [
                "arn:aws:iam::691346734154:role/service-role/*"
            ]
        }
    ]
}
```
