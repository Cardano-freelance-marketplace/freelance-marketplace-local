# Database
### SQL Database tables

- **users**: Stores user information, including roles, profiles foreign id, preferences  and details.​

- **user_roles**: Defines various roles and associates them with users.​

- **profiles**: Contains detailed profiles for both clients and freelancers, such as portfolios and ratings.​

- **jobs**: Holds information about job postings, including descriptions, requirements, budgets, and deadlines.​

- **proposal**: Manages agreements between clients and freelancers, tracking job progress and terms.​

- **transactions**: Logs financial transactions, including payments, refunds, and escrow details.​

#### Relationships and Permissions:

- **User and Roles**: Establish a many-to-many relationship between users and roles to allow flexibility in role assignments.​

- **Job and Proposal**: Implement a one-to-many relationship where each job can have multiple proposals.​

- **USERS and Jobs**: Set up a one-to-many relationship where a client can post multiple jobs.​

- **Jobs and Transactions**: Set up a one-to-many relationship where a Job can have multiple transactions.​

### NoSQL Database Collections

- **categories**: Organizes themes like 'software development' and services into various sub-categories for easy navigation.​

- **portfolios**: Contains detailed information about previous works of freelancer

- **messages**: Facilitates communication between users within the platform.​

- **notifications**: Manages system alerts and notifications for user activities.

- **reviews**: Captures feedback and ratings exchanged between clients and freelancers post-completion of jobs.​

# Roles

###  User Roles
- Admin
- User
- Guest


## **Role-Based Access Control (RBAC)**: 

Example 
```JSON
  "admin": {
    "tests": {
      "description": "Permissions related to test management.",
      "untaken": {
        "able": true,
        "description": "Permissions for untaken tests.",
        "view": {
          "description": "View-related permissions.",
          "can_view_own": true,
          "can_view_shared": true,
          "can_view_own_practice": true,
          "can_view_all": true
        },
        "send": {
          "description": "Send-related permissions.",
          "can_send_own": true,
          "can_send_shared": true,
          "can_send_own_practice": false,
          "can_send_all": true
        },
        "update": {
          "description": "Update-related permissions.",
          "can_update_own": true,
          "can_update_shared": true,
          "can_update_own_practice": false,
          "can_update_all": true
        },
        "create": {
          "description": "Create-related permissions.",
          "able": true
        },
        "manage": {
          "description": "Manage-related permissions.",
          "can_manage_own": true,
          "can_manage_shared": true,
          "can_manage_own_practice": false,
          "can_manage_all": true
        },
        "delete": {
          "description": "Delete-related permissions.",
          "can_delete_own": true,
          "can_delete_shared": true,
          "can_delete_own_practice": true,
          "can_delete_all": true
        }
      },
      "taken": {
        "description": "Permissions for taken tests.",
        "can_create_pdf": true,
        "able": true,
        "view": {
          "description": "View-related permissions.",
          "can_view_own": true,
          "can_view_shared": true,
          "can_view_own_practice": true,
          "can_view_all": true
        },
        "send": {
          "description": "Send-related permissions.",
          "can_send_own": true,
          "can_send_shared": true,
          "can_send_own_practice": true,
          "can_send_all": true
        },
        "update": {
          "description": "Update-related permissions.",
          "can_update_own": true,
          "can_update_shared": true,
          "can_update_own_practice": true,
          "can_update_all": true
        },
        "manage": {
          "description": "Manage-related permissions.",
          "can_manage_own": true,
          "can_manage_shared": true,
          "can_manage_own_practice": true,
          "can_manage_all": true
        },
        "archive": {
          "description": "Archive-related permissions.",
          "can_archive_own": true,
          "can_archive_shared": true,
          "can_archive_own_practice": true,
          "can_archive_all": true
        }
      },
      "duplicate": true
    },
  }

```

## Backend

### Endpoints

#### Users
 - GET **/user** Query(user_id: int) -> User - GET SINGLE USER
 - GET **/users** -> List[User] - GET ALL USERS
 - GET **/users/job** Query(job_id: int) -> List[User] - GET ALL USERS by job
 - DELETE **/user** Query(user_id: int) -> Bool - SOFT DELETE SINGLE USER BY ID
 - POST **/user** FORM(user_data: dict) -> Bool - CREATE USER WITH DATA
 - PATCH **/user** FORM(user_id: int, user_data: dict) -> Bool - EDIT USER WITH DATA

##### onDelete
 SOFT CascadeOnDelete ( Profiles, Portfolios)

#### User Roles
 - GET **/user/role** Query(user_id: int) -> Role - GET ROLE OF USER
 - GET **/roles** -> List[Role] - GET ALL Roles

#### Profiles
 - GET **/user/profile** Query(user_id: int) -> Profile - GET SINGLE USER PROFILE
 - POST **/user/profile** FORM(user_id: int, user_profile: dict) -> Bool - CREATE PROFILE FOR SPECIFIC USER
 - PATCH **/user/profile** FORM(user_id: int, user_profile: dict) -> Bool - EDIT PROFILE OF USER SPECIFIED
 - DELETE **/user/profile** Query(user_id: int) -> Bool - DELETE SINGLE Profile BY user id

 #### Portfolios
 - GET **/user/portfolio** Query(user_id: int) -> Portfolio - GET SINGLE USER portfolio
 - POST **/user/portfolio** FORM(user_id: int, user_portfolio: dict) -> Bool - CREATE portfolio FOR SPECIFIC USER
 - PATCH **/user/portfolio** FORM(user_id: int, user_portfolio: dict) -> Bool - EDIT portfolio OF USER SPECIFIED
 - DELETE **/user/portfolio** Query(user_id: int) -> Bool - DELETE SINGLE Portfolio BY user id

#### Reviews
 - GET **/user/review** Query(review_id: int) -> Review - GET SINGLE review
 - GET **/user/reviews** Query(user_id: int) -> List[Review] - GET ALL Reviews by User
 - POST **/user/review** FORM(user_id: int, review_data: dict) -> Bool - CREATE review FOR SPECIFIC USER
 - PATCH **/user/review** FORM(user_id: int, review_data: dict) -> Bool - EDIT review OF USER SPECIFIED
 - DELETE **/user/review** Query(review_id: int) -> Bool - DELETE SINGLE Review BY ID

#### Jobs
 - GET **/job** Query(job_id: int) -> Job - GET SINGLE JOB
 - GET **/jobs** -> List[Jobs] - GET ALL JOBS
 - GET **/jobs/user** Query(user_id: int) -> List[Jobs] - GET ALL JOBS RELATED TO A USER
 - GET **/category/jobs** Query(category_id: int) -> List[Jobs] - GET ALL jobs related to category
 - DELETE **/job** Query(job_id: int) -> Bool - DELETE SINGLE JOB BY ID
 - POST **/job** FORM(job_id: id, job_data: dict) -> Bool - CREATE JOB WITH DATA
 - PATCH **/job** FORM(job_id: int, job_data: dict) -> Bool - Update job by job_id

 ##### onDelete
 SOFT CascadeOnDelete ( Proposals )

#### Proposals
 - GET **/job/proposal** Query(job_id: int, proposal_id: int) -> Proposal - GET SINGLE proposal FROM Specific Job
 - GET **/job/proposals** Query(job_id: int) -> List[Proposals] - GET ALL proposals from specific JOB
 - DELETE **/job/proposal** Query(proposal_id: int) -> Bool - SOFT DELETE SINGLE proposal BY ID
 - POST **/job/proposal** FORM(job_id: int, proposal_data: dict) -> Bool - CREATE proposal WITH DATA
 - PATCH **/job/proposal** FORM(job_id: int, proposal_data: dict) -> Bool - EDIT proposal WITH DATA

#### Transactions
 - GET **/transaction** Query(id: int) -> Transaction - GET SINGLE transaction 
 - GET **/proposal/transaction** Query(proposal_id: int) -> Transaction - GET Transaction By Proposal_id
 - GET **/job/transactions** Query(job_id: int) -> List[Transactions] - GET ALL transactions by job
 - DELETE **/job/transaction** Query(transaction_id: int) -> Bool - DELETE SINGLE transaction BY transaction ID
 - POST **/job/transaction** FORM(job_id: int, transaction_data: dict) -> Bool - CREATE transaction WITH DATA by job_id
 - PATCH **/job/transaction** FORM(job_id: int, transaction_data: dict) -> Bool - EDIT transaction WITH DATA

#### Messages
 - GET **/message** Query(message_id: int) -> Message - GET SINGLE message by id
 - GET **/messages/author** Query(author_id: int) -> List[Message] - GET all messages by author 
 - GET **/messages/recipient** Query(recipient_id: int) -> List[Message] - GET all messages by recipient
 - GET **/messages/conversation/** Query(recipient_id: int, author_id) List[Message] - GET all messages between two users
 - GET **/job/messages/author** Query(job_id: int, author_id: int) -> List[Message] - GET all messages from job by author_id
 - GET **/job/messages** Query(job_id: int) -> List[Message] - GET ALL messages by job
 - DELETE **/message** Query(message_id: int) -> Bool - DELETE SINGLE message by message ID
 - POST **/message** FORM(author_id: int, message_data: dict) -> Bool - CREATE message WITH DATA
 - PATCH **/message** FORM(message_id: int, message_data: dict) -> Bool - EDIT message WITH DATA

#### Categories
 - GET **/category** Query(category_id: int) -> Category - GET SINGLE category
 - GET **/categories** Query(category_id: int) -> List[Category] - GET ALL categories
 - DELETE **/category** Query(category_id: int) -> Bool - DELETE SINGLE category BY ID
 - POST **/category** FORM(category_id: int, category_data: dict) -> Bool - CREATE category WITH DATA
 - PATCH **/category** FORM(category_id: int, category_data: dict) -> Bool - EDIT category WITH DATA

 #### Notifications
 - GET **/notification** Query(notification_id: int) -> Notification - GET SINGLE notification
 - GET **/user/notifications** Query(user_id: int) -> List[Notification] - GET ALL notifications by User id
 - POST **/user/notification** FORM(user_id: int, notification_data: dict) -> Bool - CREATE notification WITH DATA By user id
 - PATCH **/notification** FORM(notification_id: int, notification_data: dict) -> Bool - EDIT notification WITH DATA by notification_id
 - DELETE **/notification** Query(notification_id: int) -> Bool - DELETE SINGLE notification BY ID


## Frontend

### Pages