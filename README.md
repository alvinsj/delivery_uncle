# DeliveryUncle [![Code Climate](https://codeclimate.com/github/alvinsj/delivery_uncle.png)](https://codeclimate.com/github/alvinsj/delivery_uncle) [![Build Status](https://travis-ci.org/alvinsj/delivery_uncle.svg?branch=master)](https://travis-ci.org/alvinsj/delivery_uncle)

DeliveryUncle (Rails Engine) that you can hire to manage outgoing email.

- Provides a facade to manage various action_mailer.
- Sending email in background.
- Support scheduled email.
- .. etc

## Setup

1. Add delivery_uncle into Gemfile  
`gem 'delivery_uncle'`  

2. Install migration  
`rails generate delivery_uncle:install`

3. Start [Resque](https://github.com/resque/resque)  
`be rake environment resque:work QUEUE='*'`

## Usage

1. Send email in background with `DeliveryUncle::Deliver`  
`DeliveryUncle::Deliver.new(AccountMailer, :new_registration, user.email)`

2. Check status with mailer type with `DeliveryUncle::EmailRequest`
`DeliveryUncle::EmailRequest.where(mailer: 'AccountMailer')`

## License

This project rocks and uses MIT-LICENSE.
