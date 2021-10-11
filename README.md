## Target

The application will allow users to upload contact files in CSV format and process them in order
to generate a unified contact file. The contacts must be associated with the user who imported
them into the platform. When uploading the files, the application must validate that the fields
entered are correctly formatted. You must take into account that the files can have many
records.

## Initial setup & gems

- **DB:** Postgresql
- **Unit Testing:** Rspec
- **Login System:** Devise
- **Background job**: Sidekiq
- **Encrypting**: bcrypt
- **Pagination**: will_paginate

To run the app in the local machine, clone the project:

```ruby
git clone https://github.com/RobertoRuedaQ/contact_importer.git
```

In the terminal, go to the directory setup as any other rails project.

```ruby
bundle install
rails db:setup
```


Or if you prefer it is published in Heroku. Find it in the next link:

[ContactLoader](https://importer-contact-robert.herokuapp.com/)

For testing you may use this file already filled with data.

[File for testing](https://publiccontactimporter.s3.amazonaws.com/contact_example.csv)