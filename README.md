RD Station Web App
==================

[![Build Status](https://travis-ci.org/maxcnunes/rdstation.png?branch=master)](https://travis-ci.org/maxcnunes/rdstation)
[![Coverage Status](https://coveralls.io/repos/maxcnunes/rdstation/badge.png?branch=master)](https://coveralls.io/r/maxcnunes/rdstation?branch=master)
[![Code Climate](https://codeclimate.com/github/maxcnunes/rdstation.png)](https://codeclimate.com/github/maxcnunes/rdstation)

This is a simple demo app for import data from RD Station to Pipedrive using [Pipedrive RD Station gem](https://github.com/maxcnunes/pipedrive_rdstation).


### Install

It is not a big deal, just normal rails approach:

```bash
bundle
rake db:migrate
rails s
```


### Person Model Mapping

RD Station | Data Type | Pipedrive        | Data Type
-----------|-----------|------------------|------------------------
name       | string    | name             | string
last_name  | string    | (join with name) |
email      | string    | email            | array
company    | string    | org_id           | number
job_title  | string    | job_title        | Person Field - varchar
phone      | string    | phone            | array
website    | string    | website          | Person Field - varchar


### Pipedrive

#### Setup
Basically for Pipedrive integration work the user have to setup his Pipedrive key first. Without the Pipedrive key the application will just ignore the integration.

When the user setups the Pipedrive key, the application will store his key for all the next requests to Pipedrive API. Also will create at the first setup custom fields (job_title and website), because they doesn't exist in Pipedrive by default. These custom fields have keys which must be passed with the request when creating a person. So we store it in the database for future requests.

#### Integration
If the user has setted up his Pipedrive key, then integration will run every time he create a new Person. 

The integration will follow these basic steps bellow:

1. Create a organization in Pipedrive if company field is not blank in person data.
2. Get hash keys of job_title and website custom fields.
3. Join person name and last name, because there is only name field in Pipedrive.
4. Create the person with custom fields and organization association in Pipedrive.