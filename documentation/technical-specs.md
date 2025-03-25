# Database
### SQL Database tables

- **users**: Stores user information, including roles, profiles foreign id, preferences  and details.​

- **user_roles**: Defines various roles and associates them with users.​

- **profiles**: Contains detailed profiles for both clients and freelancers, such as portfolios and ratings.​

- **jobs**: Holds information about job postings, including descriptions, requirements, budgets, and deadlines.​

- **milestones**: Manages agreements about job steps between clients and freelancers, tracking job progress and terms.​

- **transactions**: Logs financial transactions, including payments, refunds, and escrow details.​

- **reviews**: Captures feedback and ratings exchanged between clients and freelancers post-completion of jobs.​

#### Relationships and Permissions:

- **User and Roles**: One Role has many users and one user can only have one role

- **Job and Milestone**: Implement a one-to-many relationship where each job can have multiple milestones.​

- **USERS and Jobs**: Set up a one-to-many relationship where a user can post multiple jobs.​

- **Jobs and Transactions**: Set up a one-to-many relationship where a Job can have multiple transactions.​

- **categories and sub-categories**: One-to-many relationship where one category can have multiple sub-categories

- **Jobs and sub-categories**: One-to-many relationship where one sub-category can have multiple jobs

- **reviews and users**: one-to-many relationship where one user can review multiple users, and one user can be reviewed by multiple users.


### NoSQL Database Collections

- **portfolios**: Contains detailed information about previous works of freelancer

- **messages**: Facilitates communication between users within the platform.​

- **notifications**: Manages system alerts and notifications for user activities.



## Table Schemas
### SQL
  #### Users
  ```sql
  id(Integer, Primary),
  creation_date(Datetime),
  updated_at(Datetime),
  is_activate(boolean),
  role_id(INT, NOT NULL, FOREIGN KEY),
  wallet_public_address(varchar(100), UNIQUE, NOT NULL),
  ```
  ```sql
  wallet_type(Integer, NOT NULL)
  ```
  Wallet_type will be an enum which will represent the wallet the user, uses :
  - 1 = Lace
  - 2 = Yoroi
  - etc..
  ```sql
  last_login(datetime),
  type(INTEGER), 
  ```
  Type will have values {'0': None, '1': 'freelancer', '2': 'client', '3': 'both'} USE ENUM IN API TO DECLARE WHICH IS WHICH


  #### Roles
  ```sql
  role_id(INT, Primary)
  role_name(VARCHAR(50), NOT NULL, UNIQUE)
  role_description(TEXT) 
  ```

  #### Profiles
  ```sql
  profile_id(INT, PRIMARY KEY)
  user_id(INT, NOT NULL, FOREIGN KEY),
  first_name(VARCHAR(50)),
  last_name(VARCHAR(50)),
  bio(text),
  location(varchar(100)),
  profile_picture(varchar(255)),
  contact_number(20)
  ```

 #### Jobs
 ```sql
  job_id(INT, PRIMARY),
  title(varchar(50)),
  description(TEXT),
  sub_category_id(INT, FOREIGN KEY)
  client_id(int, NOT NULL, FOREIGN KEY),
  created_at(TIMESTAMP),
  updated_at(TIMESTAMP),
  ```
  ```sql
  status(Integer)
 ```
 Status will have 4 different statuses :
 - Requested (0 - When a client creates a job but the job has no freelancer associated with it.)
 - Draft(1 - When a job has a freelancer, and users are deciding milestones, payments etc..)
 - In Progress(2 - When there are milestones to be completed.)
 - Completed(3 - When all milestones are completed)
 - Canceled(4 - When Job is canceled by the client or the freelancer)



 #### milestones
 ```sql
  milestone_id(INT, PRIMARY KEY),
  job_id(INT, NOT NULL, FOREIGN KEY),
  ```
  ```
  milestone_tx_hash(VARCHAR(100)) 
  ```
  // THIS IS THE 'ID' OF THE UTXO INSIDE THE SMART CONTRACT, UTXO''s in this case are like items in a list, that list contains the approval status of the freelancer and the client.
  Grab this UTXO reference from the blockchain transaction response
  ```
  client_id(INT, FOREIGN KEY, NOT NULL),
  freelancer_id(INT, FOREIGN KEY, NOT NULL),
  milestone_text(TEXT, NOT NULL),
  reward_amount(FLOAT, NOT NULL),
  created_at(TIMESTAMP, NOT NULL),
  client_approved(Boolean),
  freelancer_approved(Boolean),
  status(VARCHAR(50), NOT NULL),
 ```

  #### Transactions
  ```sql
  transaction_id(INT, PRIMARY KEY),
  milestone_id(INT, FOREIGN KEY, NOT NULL),
  amount(DECIMAL(10,2), NOT NULL)
  token_name(VARCHAR(50))
  receiver_address(TEXT)
  client_id(INT, FOREIGN KEY, NOT NULL)
  freelancer_id(INT, FOREIGN KEY, NOT NULL)
  ```

  #### Categories
  ```sql
  category_id(INT, PRIMARY KEY),
  category_name(varchar(50), NOT NULL),
  category_description(TEXT)
  ```

  #### Sub-Categories
  ```sql
  sub_category_id(INT, PRIMARY KEY),
  category_id(INT, FOREIGN KEY, NOT NULL),
  sub_category_name(VARCHAR(50), NOT NULL),
  sub_category_description(TEXT)
  ```

  #### Reviews
  ```sql
  review_id(INT, PRIMARY KEY)
  reviewee_id(INT, FOREIGN KEY, NOT NULL) // PERSON BEING REVIEWED
  reviewer_id(INT, FOREIGN KEY, NOT NULL)
  rating(decimal(2,1), NOT NULL CHECK(rating >= 1.0 AND rating <= 5.0))
  comment(TEXT)
  created_at(datetime)
  ```

  ### NoSQL

  #### Portfolios
  ```
    user_id: int
    portfolio_id: int
    project_title: string
    description: string
    start_date: datetime
    completion_date: datetime
    tech_stack: List[str]
    attachments: [
      {
          "file_name": str,
          "file_type": str,
          "file_data": str
      }
    ]
    images : [
      {
        image_name: str
        file_type: str
        file_data: binary_data (str)
      }
    ]
  ```

  #### Messages
  ```
  message_id: int
  sender_id: int
  receiver_id: int
  content: int
  sent_time: datetime
  received_time: datetime
  was_edited: boolean
  was_viewed: boolean
  ```

  #### Notifications
  ```
  notification_id: int
  user_id: int
  content: str
  creation_date: datetime
  was_notified: boolean
  ```

# Roles

###  User Roles
- Admin
- User
- Guest

TODO DEFINE WHAT ROLE HAS WHAT PERMISSIONS


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
```
 - GET **/user** Query(user_id: int) -> User - GET SINGLE USER
 - GET **/users** -> List[User] - GET ALL USERS
 - GET **/users/job** Query(job_id: int) -> List[User] - GET ALL USERS by job
 - DELETE **/user** Query(user_id: int) -> Bool - SOFT DELETE SINGLE USER BY ID
 - POST **/user** FORM(user_data: dict) -> Bool - CREATE USER WITH DATA
 - PATCH **/user** FORM(user_id: int, user_data: dict) -> Bool - EDIT USER WITH DATA
 ```

#### User Roles
```
 - GET **/user/role** Query(user_id: int) -> Role - GET ROLE OF USER
 - GET **/roles** -> List[Role] - GET ALL Roles
```
#### Profiles
```
 - GET **/user/profile** Query(user_id: int) -> Profile - GET SINGLE USER PROFILE
 - POST **/user/profile** FORM(user_id: int, user_profile: dict) -> Bool - CREATE PROFILE FOR SPECIFIC USER
 - PATCH **/user/profile** FORM(user_id: int, user_profile: dict) -> Bool - EDIT PROFILE OF USER SPECIFIED
 - DELETE **/user/profile** Query(user_id: int) -> Bool - DELETE SINGLE Profile BY user id
```
 #### Portfolios
 ```
 - GET **/user/portfolio** Query(user_id: int) -> Portfolio - GET SINGLE USER portfolio
 - POST **/user/portfolio** FORM(user_id: int, user_portfolio: dict) -> Bool - CREATE portfolio FOR SPECIFIC USER
 - PATCH **/user/portfolio** FORM(user_id: int, user_portfolio: dict) -> Bool - EDIT portfolio OF USER SPECIFIED
 - DELETE **/user/portfolio** Query(user_id: int) -> Bool - DELETE SINGLE Portfolio BY user id
```
#### Reviews
```
 - GET **/user/review** Query(review_id: int) -> Review - GET SINGLE review
 - GET **/user/reviews** Query(user_id: int) -> List[Review] - GET ALL Reviews by User
 - POST **/user/review** FORM(user_id: int, review_data: dict) -> Bool - CREATE review FOR SPECIFIC USER
 - PATCH **/user/review** FORM(user_id: int, review_data: dict) -> Bool - EDIT review OF USER SPECIFIED
 - DELETE **/user/review** Query(review_id: int) -> Bool - DELETE SINGLE Review BY ID
```
#### Jobs
```
 - GET **/job** Query(job_id: int) -> Job - GET SINGLE JOB
 - GET **/jobs** -> List[Jobs] - GET ALL JOBS
 - GET **/jobs/user** Query(user_id: int) -> List[Jobs] - GET ALL JOBS RELATED TO A USER
 - GET **/category/jobs** Query(category_id: int) -> List[Jobs] - GET ALL jobs related to category
 - DELETE **/job** Query(job_id: int) -> Bool - DELETE SINGLE JOB BY ID
 - POST **/job** FORM(job_id: id, job_data: dict) -> Bool - CREATE JOB WITH DATA
 - PATCH **/job** FORM(job_id: int, job_data: dict) -> Bool - Update job by job_id
 - PATCH **/job/cancel** FORM(job_id: int, user_id: int) -> Bool - Update job by job_id
```
 ##### onDelete
 SOFT CascadeOnDelete ( milestones )

#### milestones
```
 - GET **/job/milestone** Query(job_id: int, milestone_id: int) -> milestone - GET SINGLE milestone FROM Specific Job
 - GET **/job/milestones** Query(job_id: int) -> List[milestones] - GET ALL milestones from specific JOB
 - DELETE **/job/milestone** Query(milestone_id: int) -> Bool - SOFT DELETE SINGLE milestone BY ID
 - POST **/job/milestone** FORM(job_id: int, milestone_data: dict) -> Bool - CREATE milestone WITH DATA
 - PATCH **/job/milestone/approve** FORM(job_id: int, user_id: int) -> Bool - Approve milestone STATUS
 - PATCH **/job/milestone** FORM(job_id: int, milestone_data: dict) -> Bool - EDIT milestone WITH DATA
```
#### Transactions
```
 - GET **/transaction** Query(id: int) -> Transaction - GET SINGLE transaction 
 - GET **/milestone/transaction** Query(milestone_id: int) -> Transaction - GET Transaction By milestone_id
 - GET **/job/transactions** Query(job_id: int) -> List[Transactions] - GET ALL transactions by job
 - DELETE **/job/transaction** Query(transaction_id: int) -> Bool - DELETE SINGLE transaction BY transaction ID
 - POST **/job/transaction** FORM(job_id: int, transaction_data: dict) -> Bool - CREATE transaction WITH DATA by job_id
 - PATCH **/job/transaction** FORM(job_id: int, transaction_data: dict) -> Bool - EDIT transaction WITH DATA
```
#### Messages
```
 - GET **/message** Query(message_id: int) -> Message - GET SINGLE message by id
 - GET **/messages/author** Query(author_id: int) -> List[Message] - GET all messages by author 
 - GET **/messages/recipient** Query(recipient_id: int) -> List[Message] - GET all messages by recipient
 - GET **/messages/conversation/** Query(recipient_id: int, author_id) List[Message] - GET all messages between two users
 - GET **/job/messages/author** Query(job_id: int, author_id: int) -> List[Message] - GET all messages from job by author_id
 - GET **/job/messages** Query(job_id: int) -> List[Message] - GET ALL messages by job
 - DELETE **/message** Query(message_id: int) -> Bool - DELETE SINGLE message by message ID
 - POST **/message** FORM(author_id: int, message_data: dict) -> Bool - CREATE message WITH DATA
 - PATCH **/message** FORM(message_id: int, message_data: dict) -> Bool - EDIT message WITH DATA
```
#### Categories
```
 - GET **/category** Query(category_id: int) -> Category - GET SINGLE category
 - GET **/categories** Query(category_id: int) -> List[Category] - GET ALL categories
 - DELETE **/category** Query(category_id: int) -> Bool - DELETE SINGLE category BY ID
 - POST **/category** FORM(category_id: int, category_data: dict) -> Bool - CREATE category WITH DATA
 - PATCH **/category** FORM(category_id: int, category_data: dict) -> Bool - EDIT category WITH DATA
```
 #### Notifications
 ```
 - GET **/notification** Query(notification_id: int) -> Notification - GET SINGLE notification
 - GET **/user/notifications** Query(user_id: int) -> List[Notification] - GET ALL notifications by User id
 - POST **/user/notification** FORM(user_id: int, notification_data: dict) -> Bool - CREATE notification WITH DATA By user id
 - PATCH **/notification** FORM(notification_id: int, notification_data: dict) -> Bool - EDIT notification WITH DATA by notification_id
 - DELETE **/notification** Query(notification_id: int) -> Bool - DELETE SINGLE notification BY ID
```

## Frontend

### Color palette

-- TBD --

### Authentication
Login 
```markdown
# Login page
- Login will be made through browser wallets, when a user selects a wallet and successfuly logs in. 
- Grab the public address and other useful data and send to Backend, where it will be checked if the user already exists in the database. 
- If user doesn't exist, force user to fill in required information
```

### User Type
There are two user types
- **freelancer**
- **client**

In the database

#### Mesh js
- Initiate wallet connection 
```Typescript
  const connectWallet = async () => {
    try {
      const wallet = await BrowserWallet.enable("lace");
      const address = (await wallet.getUsedAddresses())[0]; // Get the user's first address

      console.log("Connected Address:", address);
      return wallet;
    } catch (error) {
      console.error("Error connecting to Lace wallet:", error);
    }
  };
```
- Build transaction
```Typescript
    const tx = new Transaction({ initiator: wallet });

    // Define the recipient and the amount to send
    tx.sendLovelace(
      "addr1qxexample...your_recipient_address...", // Replace with the recipient's address
      "5000000" // Amount in Lovelace (5 ADA)
    );

    // Optional: Add metadata (example key: 674, value: "Hello Cardano")
    tx.metadata(674, "Hello Cardano");

    // Build the transaction
    const unsignedTx = await tx.build();
```
- Sign transaction
```Typescript
const signTransaction = async (wallet: BrowserWallet, unsignedTx: string) => {
  try {
    const signedTx = await wallet.signTx(unsignedTx, true);
    console.log("Signed Transaction:", signedTx);
    return signedTx;
  } catch (error) {
    console.error("Error signing transaction:", error);
  }
};
```
- Submit transaction
```Typescript
const submitTransaction = async (wallet: BrowserWallet, signedTx: string) => {
  try {
    const txHash = await wallet.submitTx(signedTx);
    console.log("Transaction Hash:", txHash);
    return txHash;
  } catch (error) {
    console.error("Error submitting transaction:", error);
  }
};
```

### Pages