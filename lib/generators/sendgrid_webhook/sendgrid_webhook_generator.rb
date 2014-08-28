require 'rails/generators/migration'

class SendgridWebhookGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  argument :controller_name, :type => :string, :default => 'webhook'
  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"


  source_root File.expand_path('../templates', __FILE__)

  def generate_migration
    migration_template "migration.rb", "db/migrate/sendgrid_webhook_create_#{table_name}"
  end

  def generate_model
    invoke "active_record:model", [name], :migration => false
  end

  def generate_webhook_controller
    template "webhook_controller.rb", "app/controllers/#{controller_name}_controller.rb"
  end

  def append_route
    route <<ROUTE
    namespace :webhook do
      post 'email'
    end
ROUTE
  end

  private
  def migration_data
<<RUBY
    t.integer  "school_id"
    t.integer  "user_id"
    t.text     "status"
    t.string   "subject"
    t.text     "body"
    t.string   "from"
    t.text     "to"
    # t.integer  "recording_id"
    # t.string   "recording_type"
    t.datetime "created_at"
    t.datetime "updated_at"
RUBY
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
  end
end
