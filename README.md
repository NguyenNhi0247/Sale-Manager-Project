# Sale Manager
An online bookstore project.

### Prerequisites
- Local deployment/development:
  - make (if you're using Linux)
  - Docker 18.09
  - docker-compose 1.22

If you don't have `Docker` and `docker-compose` installed on your machine then you have to manually install the following tools on your machine:
- Database: Postgres 11.4
- Backend service: 
  - Python 3
  - pip3, venv
- Frontend service: 
  - NodeJS: 10.6
  - yarn

### Development
```sh
$ git clone https://github.com/lnquy/Sale-Manager-Project
$ cd Sale-Manager-Project
$ make setup-env   # Prepare local dev env and install dependencies
$ make docker-compose   # Start services for local dev
```
*Note: If you got error when installing Python's `psycopg2` package then please install `sudo apt install libpq-dev` on your machine first.*  

Services will be started and exposed at address:
  - Database: `postgres:5432` (+pgAdmin: `0.0.0.0:10000`)
  - Backend: `backend:9090`
  - Frontend: `frontend:8080`
  - NGINX proxy: `0.0.0.0:80`  
  
After that, you can open your browser and head to `http://localhost` to see the webpage.  
Backend API documents can be found at `http://localhost:9090/api/v1/apidoc`.

*Note: In case, you're using Windows or don't have `Docker` and `docker-compose` installed, then you will have to manually install all the tools in the `Prerequisites` section above and start each service by yourself.*  
*You can reference to the `setup-env`, `fe-start-dev` and `be-start-dev` profiles in the `Makefile` to know which commands must be run in order to manually setup the local development environment.*


### Database management
- After start the local environment by `docker-compose`, you can access `pgAdmin` at `http://localhost:10000`.
- Email/Password: `admin@local.dev` / `123456x@X`
- Create new connection to Postgres database with details below:
  - Hostname/Address: `postgres`
  - Port: `5432`
  - Username: `postgres`
  - Password: `123456x@X`

### LICENSE
This project is under the MIT License.
