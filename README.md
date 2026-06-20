# Ecodev-infra

This library is based on Ecodev-Infra, for which the documentation can be found [here](https://ecodev-doc.lcabox.com/cookiecutters/infra/)

This repository takes off-the-shelf docker images for 
- traefik
- postgresql db and pgadmin interface


## Installation


1. Clone [fitboard-infra](https://github.com/AmaurySalles/fitboard-infra) via:
	`git clone https://github.com/AmaurySalles/fitboard-infra.git`

2. If need be, follow [this documentation to setup the VM](https://ecodev-doc.lcabox.com/cookiecutters/infra/setup/setup_ubuntu_vm/)

3. Create new .env file at the root of `fitboard-infra/` directory with the following variable:
```.env
POSTGRES_DB= the db name to which your application will connect to
POSTGRES_USER: the user authorized to connect to `POSTGRES_DB`
POSTGRES_PASSWORD: the password associated to `POSTGRES_USER`

# Optional
PGADMIN_DEFAULT_EMAIL: the username to connect to the pgAdmin web interface.
PGADMIN_DEFAULT_PASSWORD: the password to connect to the pgAdmin web interface 
pgadmin_url= # Entry to the DNS address you created in order to reach the pgadmin interface.
```

***If changing the `POSTGRES_*` variables, you must delete the `db_data/` directory !***


4. Start the database container and network with the following command:
	`make db-launch`
	
	It should download the docker images and you should see confirmation that it has all started correctly:	
	![[Pasted image 20260502214958.png]]

---
### (Optional) Link to database via pgAdmin
1. Login to `pgadmin_url` with `PGADMIN_DEFAULT_*` credentials from the `.env` file
	![[Pasted image 20260502215521.png]]

2. Create connection to the `db` container, with the `POSTGRES_*` credentials from `.env` file :
	![[Pasted image 20260502214004.png]]
	![[Pasted image 20260502214038.png]]

3. Verify access to the `fitboard_db`
	![[Pasted image 20260502214143.png]]
