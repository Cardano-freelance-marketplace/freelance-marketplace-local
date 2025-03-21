# Database
### SQL Database tables

- **users**: Stores user information, including roles, profiles, and authentication details.​

- **user_roles**: Defines various roles and associates them with users.​

- **profiles**: Contains detailed profiles for both clients and freelancers, such as portfolios and ratings.​

- **jobs**: Holds information about job postings, including descriptions, requirements, budgets, and deadlines.​

- **proposals**: Records bids or proposals submitted by freelancers for specific jobs.​

- **contracts**: Manages agreements between clients and freelancers, tracking job progress and terms.​

- **transactions**: Logs financial transactions, including payments, refunds, and escrow details.​

- **categories**: Organizes jobs and services into various categories for easy navigation.​

### NoSQL Database Collections

- **portfolios**: Contains detailed information about previous works of freelancer

- **messages**: Facilitates communication between users within the platform.​

- **notifications**: Manages system alerts and notifications for user activities.

- **reviews**: Captures feedback and ratings exchanged between clients and freelancers post-completion of jobs.​


### Relationships and Permissions:

- **User and Roles**: Establish a many-to-many relationship between users and roles to allow flexibility in role assignments.​

- Job and Proposals: Implement a one-to-many relationship where each job can have multiple proposals from different freelancers.​

- **Client and Jobs**: Set up a one-to-many relationship where a client can post multiple jobs.​

- **Freelancer and Contracts**: Design a one-to-many relationship where a freelancer can have multiple contracts.​


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
    "questions": {
      "description": "Permissions related to question management.",
      "unevaluated": {
        "able": true,
        "description": "Permissions for unevaluated questions.",
        "view": {
          "description": "View-related permissions.",
          "can_view_own": true,
          "can_view_own_practice": true,
          "can_view_all": true
        },
        "update": {
          "description": "Update-related permissions.",
          "can_update_own": true,
          "can_update_own_practice": true,
          "can_update_all": true
        },
        "create": {
          "description": "Create-related permissions.",
          "generate": {
            "able": true,
            "description": "description_test_value"
          },
          "manual": {
            "description": "description_test_value",
            "able": true
          }
        },
        "delete": {
          "description": "Delete-related permissions.",
          "can_delete_own": true,
          "can_delete_own_practice": true,
          "can_delete_own_all": true
        },
        "approve": {
          "description": "Approve-related permissions.",
          "can_approve_own_practice": true,
          "can_approve_own": true,
          "can_approve_all": true
        }
      },
      "validated": {
        "description": "Permissions for validated questions.",
        "able": true,
        "view": {
          "description": "View-related permissions.",
          "can_view_own": true,
          "can_view_own_practice": true,
          "can_view_all": true
        },
        "update": {
          "description": "Update-related permissions.",
          "can_update_own": true,
          "can_update_own_practice": true,
          "can_update_all": true
        },
        "archive": {
          "description": "Archive-related permissions.",
          "can_archive_own": true,
          "can_archive_own_practice": true,
          "can_archive_all": true
        }
      }
    },
    "management": {
      "description": "Permissions related to management functionalities.",
      "practices": {
        "able": true,
        "tags": {
          "view": {
            "description": "View-related permissions.",
            "can_view_own_practice": true,
            "can_view_all": true
          },
          "create": {
            "description": "Create-related permissions.",
            "can_create_own_practice": true,
            "can_create_all": true
          },
          "update": {
            "description": "Update-related permissions.",
            "can_update_own_practice": true,
            "can_update_all": true
          },
          "delete": {
            "description": "Delete-related permissions.",
            "can_delete_own_practice": true,
            "can_delete_all": true
          }
        },
        "description": "Permissions for managing tags in practices.",
        "view": {
          "description": "View-related permissions.",
          "can_view_own_practice": true,
          "can_view_all": true
        },
        "update": {
          "description": "Update-related permissions.",
          "can_update_own_practice": true,
          "can_update_all": true
        },
        "create": true,
        "delete": {
          "description": "Delete-related permissions.",
          "can_delete_own_practice": true,
          "can_delete_all": true
        }
      },

```

## API

### Endpoints

#### Users
 - GET **/user** Query(id: int) - GET SINGLE USER
 - GET **/users** - GET ALL USERS
 - DELETE **/user** Query(id: int) - DELETE SINGLE USER BY ID
 - POST **/user** FORM(user_data) - CREATE USER WITH DATA
 - PATCH **/user** FORM(id: int, user_data) - EDIT USER WITH DATA

#### Profiles

#### Portfolios

#### Messages

#### User Roles
 - GET **/user/role** Query(id: int) - GET ROLE OF USER
 - GET **/roles** - GET ALL USERS
 - PATCH **/user/role** FORM(id: int, role) - UPDATE USER ROLE

#### Jobs
 - GET **/job** Query(id: int) - GET SINGLE JOB
 - GET **/jobs** - GET ALL JOBS
 - DELETE **/job** Query(id: int) - DELETE SINGLE JOB BY ID
 - POST **/job** FORM(job_data) - CREATE JOB WITH DATA
 - PATCH **/job** FORM(id: int, job_data)
