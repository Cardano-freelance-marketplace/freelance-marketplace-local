# Database
### SQL Database tables

- **users**: Stores user information, including roles, profiles foreign id, preferences  and details.​

- **user_types**: Stores user type {'0': None, '1': 'freelancer', '2': 'client', '3': 'both'}

- **user_roles**: Defines various roles and associates them with users.​

- **wallet_types**: Defines table to save all available wallet types

- **user_skills**: Defines skills for each user profile

- **profiles**: Contains detailed profiles for both clients and freelancers, such as portfolios and ratings.​

- **jobs**: Holds information about job postings, including descriptions, requirements, budgets, and deadlines.​

- **job_status**: Holds information about all available job statuses

- **job_type**: Holds information about all available job types

- **milestones**: Manages agreements about job steps between clients and freelancers, tracking job progress and terms.​

- **milestone_types**: Holds information about all available milestone types

- **milestone_status**: Holds information about all available milestone status

- **proposals**: When a client creates a job, freelancers can propose on milestones and rewards

- **orders**: When a freelancer proposes a job, clients can queue up on orders.

- **transactions**: Logs financial transactions, including payments, refunds, and escrow details.​

- **categories**: Saves all categories, which will have sub-categories.​

- **sub-categories**: Saves all sub-categories, which will have jobs associated with them.​

- **reviews**: Captures feedback and ratings exchanged between clients and freelancers post-completion of jobs.​

#### Relationships and Permissions:

- **User and Roles**: One Role has many users and one user can only have one role

- **User and Types**: One Type has many users and one user can only have one Type

- **User and wallet type**: One user has one wallet type, one wallet type has many users

- **Profile and Skills**: One Profile has many skills and one skill has many Profiles.

- **Job and Milestone**: Implement a one-to-many relationship where each job can have multiple milestones.​

- **Job and Job type**: Implement a one-to-many relationship where each job has one type, one type has many jobs.

- **Job and Job status**: Implement a one-to-many relationship where each job has one status, one status has many jobs.

- **Jobs and sub-categories**: One-to-many relationship where one sub-category can have multiple jobs

- **Job and Proposal**: Implement a one-to-many relationship where each job can have multiple proposals.​

- **Job and Order**: Implement a one-to-many relationship where each job can have multiple orders.​

- **Milestones and jobs**: Implement a one-to-many relationship where each job has many milestones, one milestone has one job.

- **Milestone and milestone types**: Implement a one-to-many relationship where each milestone has one type and one type has many milestones

- **Milestone and milestone statuses**: Implement a one-to-many relationship where each milestone has one status and one status has many milestones

- **USERS and Jobs**: Set up a one-to-many relationship where a user can post multiple jobs.​

- **USER and Proposals**: Set up a one-to-many relationship where a user can post multiple proposals.​

- **USER and orders**: Set up a one-to-many relationship where a user can post multiple orders.​

- **Jobs and Transactions**: Set up a one-to-many relationship where a Job can have multiple transactions.​

- **categories and sub-categories**: One-to-many relationship where one category can have multiple sub-categories

- **reviews and users**: one-to-many relationship where one user can review multiple users, and one user can be reviewed by multiple users.


### NoSQL Database Collections

- **portfolios**: Contains detailed information about previous works of freelancer

- **messages**: Facilitates communication between users within the platform.​

- **notifications**: Manages system alerts and notifications for user activities.

- **wishlists**: Wishlists are a list of jobs a user has liked



## Table Schemas
### SQL
  #### Users
  ```sql
  id(Integer, Primary),
  creation_date(Datetime),
  updated_at(Datetime),
  is_activate(boolean),
  is_deleted(boolean),
  role_id(INT, NOT NULL, FOREIGN KEY),
  wallet_public_address(varchar(100), UNIQUE, NOT NULL),
  ```
  ```sql
  wallet_type_id(Integer, FOREIGN KEY, NOT NULL)
  ```
  Wallet_type will be an enum which will represent the wallet the user, uses :
  - 1 = Lace
  - 2 = Yoroi
  - etc..
  ```sql
  last_login(datetime),
  type_id(INTEGER, FOREIGN KEY), 
  ```
  Type will have values {'0': None, '1': 'freelancer', '2': 'client', '3': 'both'} USE ENUM IN API TO DECLARE WHICH IS WHICH

  #### User types
  ```
  type_id(INT, PRIMARY KEY)
  type_name(STRING)
  type_description(STRING)
    
    // Type will have values {'0': None, '1': 'freelancer', '2': 'client', '3': 'both'}
  ```


  #### Wallet types
  ```
  wallet_type_id(INT, PRIMARY KEY)
  wallet_type_name(STRING)
  ```

  #### Roles
  ```sql
  role_id(INT, Primary)
  role_name(VARCHAR(50), NOT NULL, UNIQUE)
  role_description(TEXT) 
  ```

  #### user_skills
  ```sql
  id(INT, Primary)
  keyword(VARCHAR(50), NOT NULL, UNIQUE)
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
  sub_category_id(INT, FOREIGN KEY),
  total_price(float, NULLABLE),
  tags(list of strings), //USE THIS TO SEARCH FOR A JOB BY KEYWORDS
  client_id(int, FOREIGN KEY),
  freelancer_id(INT, FOREIGN KEY)
  created_at(TIMESTAMP),
  updated_at(TIMESTAMP),
  job_type_id(INTEGER, FOREIGN KEY, NOT NULL) REFERENCES JOB_TYPES TABLE
  ```
  ```sql
  status(Integer, FOREIGN KEY) REFERENCES JOB_STATUS TABLE
 ```
 Status will have 6 different statuses :
 - **Pending Approval** (0 - When a job of type request or service is created, needs to be approved by platform, to see if it follows ToS)
 - **Approved** (1 - Ready to be displayed on the platform)
 - **Draft** (2 - When a job has found a freelancer/client, and is approving milestones and rewards defined by the client/freelancer.)
 - **In Progress** (3 - After the job is created and the funds are allocated on the smart contract)
 - **Completed** (4 - When all milestones are completed)
 - **Canceled** (5 - When Job is canceled by the client or the freelancer)

 #### Job type
 ```
  job_type_id(INT, PRIMARY)
  job_type_name(STRING)
  job_type_description(STRING)

 TABLE TO SAVE JOB TYPES (SERVICE OR REQUEST)
 ```

  #### Job Status
 ```
  job_status_id(INT, PRIMARY)
  job_status_name(STRING)
  job_status_description(STRING)

 Status will have 6 different statuses :
 - **Pending Approval** (0 - When a job of type request or service is created, needs to be approved by platform, to see if it follows ToS)
 - **Approved** (1 - Ready to be displayed on the platform)
 - **Draft** (2 - When a job has found a freelancer/client, and is approving milestones and rewards defined by the client/freelancer.)
 - **In Progress** (3 - After the job is created and the funds are allocated on the smart contract)
 - **Completed** (4 - When all milestones are completed)
 - **Canceled** (5 - When Job is canceled by the client or the freelancer)
 ```

 #### milestones
 ```sql
  milestone_id(INT, PRIMARY KEY),
  job_id(INT, NOT NULL, FOREIGN KEY),
  ```
  ```
  milestone_tx_hash(VARCHAR(100)) 
  ```
  THIS IS THE 'ID' OF THE UTXO INSIDE THE SMART CONTRACT, UTXO''s in this case are like items in a list, that list contains the approval status of the freelancer and the client.
  Grab this UTXO reference from the blockchain transaction response
  ```
  client_id(INT, FOREIGN KEY, NOT NULL),
  freelancer_id(INT, FOREIGN KEY, NOT NULL),
  milestone_text(TEXT, NOT NULL),
  reward_amount(FLOAT, NOT NULL),
  created_at(TIMESTAMP, NOT NULL),
  client_approved(Boolean),
  freelancer_approved(Boolean),
  milestone_status_id(Integer, FOREIGN KEY) REFERENCES MILESTONE_STATUS TABLE
 ```
 Type is a column to save which type of milestone it is. If its a milestone belonging to a proposal or a job milestone
 ```
  milestone_type_id(INT, FOREIGN KEY, NOT NULL) REFERENCES MILESTONE_TYPE TABLE
```

 #### Milestone type
 ```
  milestone_type_id(INT, PRIMARY)
  milestone_type_name(STRING)
  milestone_type_description(STRING)

 TABLE TO SAVE Milestone TYPES (SERVICE OR REQUEST)
 ```

  #### Milestone Status
 ```
  milestone_status_id(INT, PRIMARY)
  milestone_status_name(STRING)
  milestone_status_description(STRING)

  DRAFT = 0
  IN_PROGRESS = 1
  COMPLETED = 2
 ```

  #### proposals
  ```sql
  proposal_id(INT, PRIMARY KEY),
  milestone_id(INT, FOREIGN KEY),
  job_id(INT, FOREIGN KEY, NOT NULL),
  freelancer_id(INT, FOREIGN KEY, NOT NULL)
  ```

  #### orders
  ```sql
  order_id(INT, PRIMARY KEY),
  job_id(INT, FOREIGN KEY, NOT NULL),
  milestone_id(INT, FOREIGN KEY),
  client_id(NT, FOREIGN KEY, NOT NULL)
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
    projects: [
      {
        "project_title": str,
        "description": str,
        "start_date": datetime,
        "completion_date": datetime,
        "tech_stack": List[str]
        images : [
          {
            image_name: str
            file_type: str
            file_data: binary_data (str)
          }
        ]
        attachments: [
          {
              "file_name": str,
              "file_type": str,
              "file_data": str
          }
        ]
      }
    ]
  ```

  #### Messages
  ```
  message_id: int
  sender_id: int
  receiver_id: int
  content: str
  sent_time: datetime
  received_time: datetime
  is_edited: boolean
  is_viewed: boolean
  ```

  #### Notifications
  ```
  notification_id: int
  user_id: int
  content: str
  creation_date: datetime
  was_notified: boolean
  ```

  #### Wishlists
  ```
  user_id: int
  lists: [
    "webdevelopment_indian_content": {
      creation_date: datetime
      description: string
      lists: {
        "services": [job_id1, job_id2, job_id3],
        "requests": [job_id1, job_id2, job_id3]
      }
    },
    "kamasutra": {
      creation_date: datetime
      description: string
      lists: {
        "services": [job_id1, job_id2, job_id3],
        "requests": [job_id1, job_id2, job_id3]
      }
    },
    "watch later": {
      creation_date: datetime
      description: string
      lists: {
        "services": [job_id1, job_id2, job_id3],
        "requests": [job_id1, job_id2, job_id3]
      }
    },
  ]
  ```

# Roles

###  User Roles
- Admin
- User
- Guest


## Backend

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

### Middlewares
```
login_validator - verify JWT token, check if user is logged in to access private endpoints.
role_validator - Verify Role inside jwt token, to check if user has permissions to access endpoint.
```

### Endpoints

#### Auth
```
 - POST **/login** Form(signed_transaction: str) -> JWT Token - Login user by checking signed transaction, if valid, return JWT Token with signature.
 - POST **/authorization** Form(route: str) -> bool - If user attempts at accessing private route, check with API if user has permissions
```

#### Users
```
 - GET **/user** Query(user_id: int) -> User - GET SINGLE USER
 - GET **/users** -> List[User] - GET ALL USERS
 - GET **/users/job** Query(job_id: int) -> List[User] - GET ALL USERS by job
 - DELETE **/user** Query(user_id: int) -> Bool - SOFT DELETE SINGLE USER BY ID
 - POST **/user** FORM(user_id, user_data: dict) -> Bool - CREATE USER WITH DATA
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
#### milestones
```
 - GET **/milestone** Query(milestone_id: int) -> milestone - GET SINGLE milestone
 - GET **/job/milestones** Query(job_id: int) -> List[milestones] - GET ALL milestones from specific JOB
 - DELETE **/job/milestone** Query(milestone_id: int) -> Bool - SOFT DELETE SINGLE milestone BY ID
 - POST **/job/milestone** FORM(job_id: int, milestone_data: dict) -> Bool - CREATE milestone WITH DATA
 - PATCH **/job/milestone/approve** FORM(job_id: int, user_id: int) -> Bool - Approve User milestone STATUS
 - PATCH **/job/milestone/reject** FORM(job_id: int, user_id: int) -> Bool - reject User milestone STATUS
 - PATCH **/job/milestone** FORM(job_id: int, milestone_data: dict) -> Bool - EDIT milestone WITH DATA
```
 #### proposals
 ```
 - GET **/proposal** Query(proposal_id: int) -> Proposal - GET SINGLE proposal
 - GET **/proposal/user** Query(user_id: int) -> List[Proposal] - GET ALL PROPOSALS BY USER
 - GET **/proposal/job** Query(job_id: int) -> List[Proposal] - GET ALL PROPOSALS BY JOB
 - POST **/proposal** FORM(job_id: int, proposal_data: dict) -> Bool - CREATE a proposal for a specific job
 - PATCH **/proposal** FORM(proposal_id: int, proposal_data: dict) -> Bool - EDIT proposal for a specific job
 - DELETE **/proposal** Query(proposal_id: int) -> Bool - DELETE proposal by proposal_id
```

 #### orders
 ```
 - GET **/order** Query(order_id: int) -> order - GET SINGLE order
 - GET **/order/pending/user** Query(user_id: int) -> List[order] - GET ALL PENDING orders BY USER
 - GET **/order/pending/job** Query(job_id: int) -> List[order] - GET ALL PENDING orders BY JOB
 - GET **/order/active/user** Query(user_id: int) -> List[order] - GET ALL active orders BY USER
 - GET **/order/active/job** Query(job_id: int) -> order - GET active order BY JOB
 - GET **/order/all/user** Query(user_id: int) -> List[order] - GET ALL orders BY USER
 - GET **/order/all/job** Query(job_id: int) -> order - GET active BY JOB
 - POST **/order** FORM(job_id: int, order_data: dict) -> Bool - CREATE a order for a specific job
 - PATCH **/order** FORM(order_id: int, order_data: dict) -> Bool - EDIT order
 - DELETE **/order** Query(order_id: int) -> Bool - DELETE order by order_id
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
 - GET **/messages/inbox/** Query(user_id: int) List[Message] - GET ALL MESSAGES WHERE THIS USER PARTICIPATES
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
```
#111218
#d84b16
#b0b0b0
#ffffff
```

### Authentication
Login 
```markdown
# Login page
- Login will be made through browser wallets, when a user selects a wallet and successfuly logs in. 
- Grab the public address and other useful data and send to Backend, where it will be checked if the user already exists in the database. 
- If user doesn't exist, force user to fill in required information
```

### Route Authorization
```
On each private route, send request to the API to check if user has permissions to access specified route.
```


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

#### Login
```
Login will be made through the navbar where user selects 'Connect wallet'.
Selects the wallet from a side menu.
And then a MeshJS prompt window will pop up for the user to sign a transaction to confirm their identity.
```
![alt text](images/connect_prompt.png)
![alt text](images/login_connect.png)

#### Index
```
Overview of the project
If not logged in, show "Connect Wallet"
If logged in, Show "Create Proposal", "Create order"
https://minswap.org
```

#### Navbar
```
Logo - redirects to home page

Jobs - Left side menu which shows all categories and beaneath each category, show all subcategories

messages icon

SearchBar - When you click the search bar, there will be a div below with a few buttons (people, jobs, orders, proposals), when you click on a button anything you type will search on that topic, if nothing is selected, a default value of jobs will be queried

wishlist (heart icon)
notifications icon
User avatar - dropdown (profile, my jobs - requests and services, logout)
```
![alt text](images/search-bar-example.png)
![alt text](images/navbar_profile.png)
![alt text](images/navbar_job_search_category.png)
To search for a job you have a couple of options : 
- Search using the side bar.
- Search using the search by in the middle of the navbar.

#### Profile
```
Portfolio and reviews

https://www.fiverr.com/linkbuilders_?source=gig_cards&referrer_gig_slug=build-professional-responsive-wordpress-landing-page-elementor-landing-page-we&ref_ctx_id=63a9cdb4e830429d9421272e9c6775f7&imp_id=e7baf620-5274-41c0-a651-075a3cce4176
```

#### Notifications
```
Dropdown where you can see your notifications
```
![alt text](images/notifications.png)

#### Inbox
```
Page where you can chat with other persons
```
![alt text](images/inbox.png)

#### Wishlist
```
Page where you can see saved jobs grouped by list
```
![alt text](images/wishlist_list.png)
![alt text](images/wishlist_details.png)

#### My jobs
```markdown
Page where you can see detail about active orders and active proposals

Page where you can see detail about pending orders and pending proposals
```

#### Jobs
```markdown
Page where you can see all jobs (services and/or requests) 

Filter: job type, date, name, tag, author

Sorters: Price, date, rating

Info about job:
- Title
- Small job description
- Total price
- Type (service or request)
```
![alt text](images/job_grid.png)

#### Jobs details
```markdown
Details about current job
- Milestones
- Description
- Total price
- Type (service or request)

If the job is of type request (requested by a client) then have the ablity to create a proposal defines milestones and rewards
```

#### Footer
```
```

#### FAQ
```
```

#### About
```
```

### Toastify Messages
```
Success Message
Warning Message
Error message
```

### Routes
```
  /index
  /unauthorized - Page when user tries to access a page they dont have permissions
  /notFound - Page when user tries to access a page that doesnt exist

  /profile (PRIVATE)
  /profile/jobs  (PRIVATE) - View own jobs
  /profile/reviews  (PRIVATE) - View reviews i performed, and reviews on me
  /profile/orders (PRIVATE) - View my orders, and orders on my jobs
  /profile/proposals (PRIVATE) - View my proposals
  /portfolio (PRIVATE) - view my portfolio
  /wishlists (PRIVATE) - view my wishlists
  /inbox (PRIVATE)- view my messages

  /jobs (PUBLIC) - view all jobs
  /jobs/:id (PUBLIC) - view specific job
  /people (PUBLIC) - view grid of people matching my search
  /people/:id (PUBLIC) - View profile of another user
  /about (PUBLIC) - view website's about page
  /faq (PUBLIC) - view FAQ of website
  
```
