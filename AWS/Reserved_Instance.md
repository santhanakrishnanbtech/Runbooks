### Pricing
https://aws.amazon.com/savingsplans/faq/
https://aws.amazon.com/rds/postgresql/pricing/
https://aws.amazon.com/rds/pricing/
https://www.amazonaws.cn/en/rds/pricing/
https://docs.amazonaws.cn/en_us/AmazonRDS/latest/UserGuide/USER_WorkingWithReservedDBInstances.html

#### Price projection
https://aws.amazon.com/ec2/pricing/reserved-instances/pricing/

### Purchase
https://www.youtube.com/watch?v=6oGgPOlnf8g
#### Standard RI
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-concepts-buying.html#ri-buying-standard
#### Convertible RI
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-concepts-buying.html#ri-buying-convertible

### Queries
1. How are AWS Reserved Instances billed?
- 1 year and 3 year billing
- 75% for upfront
- 30% for no upfront
- https://aws.amazon.com/ec2/pricing/reserved-instances/

2. Can reserved instances be Cancelled?
- No 

3. In what ways can I modify or exchange my Amazon Reserved Instances ?
- standard can change few things
- convertible can change the instance type
- https://docs.aws.amazon.com/whitepapers/latest/cost-optimization-reservation-models/standard-vs.-convertible-offering-classes.html
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html


4. If i choose t2.micro and upgrade to t2.medium, how is billing? (Upfront)
- ???

5. What’s the difference between AWS RIs with Availability Zone Scope and Regional Scope ?
- ???

6. Does AWS charge for stopped reserved instances?
- Still be charged for RI stopped

7. Do AWS Reserved Instances automatically renew?
- No
- When expires we need to purchase
- Once price expires it will turn to on-demand
- When I renew the instance the on-demand instance changes to RI

8. Can a Reserved Instance be moved from one region to another?
- No
- Yes within AZ Scope
- When I purchase RI we can optionally select AZ or not, Not mandatory. ???

9. Can we use ri for linked multi account architecture ?
- We can share it with multi account. ???
- https://aws.amazon.com/premiumsupport/knowledge-center/ec2-ri-consolidated-billing/
- https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/ri-behavior.html
- No it will not, It will be applicable only for the account.

10. Rds ri ?
- https://aws.amazon.com/rds/reserved-instances/

11. Are Reserved Instances region specific?
- Yes

12. When we upgrade or downgrade instance type, what will be the impact on the RI pricing?
- ???
- Only upgrade and No downgrade

13. Do you have docs or videos for implementing the RI in organization level account ?
- Find above inline
