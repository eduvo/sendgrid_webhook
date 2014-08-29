# SendgridWebhook

  SendgridWebhook help you to generate the templates you need when you want to track the state of you email in your app.
  You could assign the controller name you want to receive the sendgrid webhook and model name to track the email.

## Installation

Add this line to your application's Gemfile:

    gem 'sendgrid'
    gem 'sendgrid_webhook'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sendgrid_webhook

## Usage


    $ rails generate sendgrid_webhook

1. Generate templates that controller you need to receive sendgrid webhook and model you want to track the email state. The default controller name is Webhook and model name is EmailHistroy. You assgin the name you want or skip it. For example `rails generate sendgrid_webhook hook EmailLog`

```ruby
      class MessageMailer < ActionMailer::Base
        include SendGrid

        def messaging(history_id)
          email_history = EmailHistory.find(history_id)
          @body = email_history.body
          @school = email_history.school

          sendgrid_unique_args :email_history_id => email_history.id, :env => Rails.env

          mail(:from => email_history.from, :to => email_history.to,  :subject => email_history.subject) do |format|
            format.text { render :layout => false }
          end
        end
      end
```

2. Then Include the SendGrid in your Mailer, and setup the unique_args that you need to track the email. For example, the email_histroy_id
    

```ruby
   # webhook_controller.rb

    def email
      params["_json"].group_by{|rsp| rsp["email_histroy_id"]}.each do |email_histroy_id, rsp_hash|
        last_email_rsp = rsp_hash.sort_by{|h| h["timestamp"]}.last

        if last_email_rsp["env"] == Rails.env
          EmailHistroy.find(email_histroy_id).update_attributes(:status => last_email_rsp["event"])
        end
      end
      render :nothing => true
    end
 ```

Then handle the webhook whatever you want, it is the default template.


Other thing you may need to know.

1. The sendgrid don't have their message id when you sending the mail, so you need to create your own (In this example is `sendgrid_unique_args :email_history_id => email_history.id`) through X-SMTPAPI insert the unique argument, you could know more from [Unique Arguments](http://sendgrid.com/docs/API_Reference/SMTP_API/unique_arguments.html)

2. Sendgrid account only could bind one webhook url, so if you have several applications or environments, you may need to use their new service [reflector.io](https://reflector.io) that will broadcast your webhook. Then you could check the environment or application through the params you insert in the header(In this example is `sendgrid_unique_args :env => Rails.env`)


## Contributing

1. Fork it ( http://github.com/<my-github-username>/sendgrid_webhook/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
