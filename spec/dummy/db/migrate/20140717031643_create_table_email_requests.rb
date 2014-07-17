class CreateTableEmailRequests < ActiveRecord::Migration
  def change
    create_table :delivery_uncle_email_requests do |t|
      t.text :mail_body
      t.string :mailer
      t.string :mailer_method
      t.string :mail_type
      t.string :request_from
      t.string :status

      t.timestamps
    end
  end
end
