---
published: false
---
## A hiring project

I caught word that some company was hiring devs, so I decided to take the bait. I answered the first couple of riddles that ended up in a text with the requirements about a hiring project.

 I'll document the steps and decisions I made until the project was finished.

### The stack

After evaluating the trends I decided to use the following:

- Backend: Django on AWS Lambda + API Gateway ([Nice guide](https://blog.apcelent.com/deploy-django-app-aws-lambda.html) about how to do this with [Zappa](https://www.zappa.io/))
  - Docker as Postgresql database (only on my dev machine).
  - Django's test runner for tests
Frontend: Vue.JS served from S3


### Setup environment

- Create a virtualenv
- Create the project directory and then `git init` it.
- Create backend and frontend directores. The django code goes to `backend`, and the vuej.js thingy goes to `frontend`.
- Save the requirements.txt file for the frontend according to ([the guide](https://blog.apcelent.com/deploy-django-app-aws-lambda.html) and then `pip install` the requirements.



