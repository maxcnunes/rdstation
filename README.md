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