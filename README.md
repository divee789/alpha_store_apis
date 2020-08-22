<h1 align='center'><b>alpha stores</b></h1>  
<p align='center'>
APIs for building a digital marketplace where numerous users can buy and sell content, services and goods.
</p>

<p align="center">
Built with 💖 by <a href='https://github.com/divee789'>Divine Olokor</a>
</p>

## **Features**

alpha stores aims to be an app where the physical marketplace experience is digitalized and streamlined. Users will be able to buy and sell goods from the comfort of their homes.

## **Prerequisites**

Before you begin, ensure you have installed the latest version of:

- [Ruby](https://www.ruby-lang.org/en/)
- [Rails](https://rubyonrails.org/)
- [mySQL](https://www.mysql.org/)

**Installing**

- Clone this repo to your local machine `git clone git <this-repo-url>`

- `cd` to `alpha_store_apis`

- Ensure you have mySQL running

- Configure your database settings in the `database.yml` file

- Provide your database credentials and your jwt secret key via `rails credentials:edit`.The secret variables to be set are `Rails.application.secrets.secret_key_base`, `Rails.application.credentials.database_password` and `Rails.application.credentials.sendgrid_api_key`

- run `rails db:migrate` to create tables into the database

- run `rails s` to start the server at `localhost:3000`

**TODOS**

- Implement better error handling in the app

- Use Cloudinary for image and file handling

- Create APIs for admin level functionalities

- Set up Cross Origin to protect the app from unauthorized domains.

- Implement 3rd Party payment processors -- This could possibly be carried out on the client-side though.

- Deployment to DigitalOcean
