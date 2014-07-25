# DeliveryUncle [![Code Climate](https://codeclimate.com/github/alvinsj/delivery_uncle.png)](https://codeclimate.com/github/alvinsj/delivery_uncle) [![Build Status](https://travis-ci.org/alvinsj/delivery_uncle.svg?branch=master)](https://travis-ci.org/alvinsj/delivery_uncle)

DeliveryUncle (Rails Engine) that you can hire to manage outgoing email. It provides:

- Service object to deliver action_mailer's mail message. i.e. `DeliveryUncle::Deliver`
- Records of outgoing emails requests in database. i.e. `DeliveryUncle::EmailRequest`
- Email sending in background by default (currently with Resque). 
- Views to manage (e.g. block/unblock) outgoing emails.
- .. etc

## Setup

1. Add delivery_uncle into Gemfile  
`gem 'delivery_uncle'`  

2. Install migration  
`rails generate delivery_uncle:install`

3. Start [Resque](https://github.com/resque/resque)  
`rake environment resque:work QUEUE='*'`

## Usage

1. Send email with service object: `DeliveryUncle::Deliver`  
`DeliveryUncle::Deliver.new(AccountMailer, :new_registration, user.email)`

2. Check the email records (e.g. status) with the model: `DeliveryUncle::EmailRequest`
`DeliveryUncle::EmailRequest.where(mailer: 'AccountMailer')`

3. Mount views to your rails app in `config/routes.rb`  
`mount DeliveryUncle::Engine => "/mails"`

## Changes

### v0.1.2
- Save email request
- Send email in background
- Block/unblock/pause/retry outgoing emails in views

### v0.1.3
- Remove record manipulation after enqueuing to background

## License

This project rocks and uses MIT-LICENSE.
