require 'rails/generators/migration'

class SendgridWebhookGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  argument :controller_name, :type => :string, :default => 'webhook'
  argument :model_name, :type => :string, :default => 'EmailHistory'
  class_option :controller, :type => :boolean, :default => true, :desc => "Webhook controller file."
  class_option :model, :type => :boolean, :default => true, :desc => "EmailHistory Model file."

  source_root File.expand_path('../templates', __FILE__)

  def generate_migration
    migration_template "migration.rb", "db/migrate/sendgrid_webhook_create_#{table_name.tableize}.rb" if options.model?
  end

  def generate_model
    invoke "active_record:model", [model_name], :migration => false if options.model?
  end

  def generate_webhook_controller
    if options.controller?
    template "webhook_controller.rb", "app/controllers/#{controller_name.underscore}_controller.rb"

    route <<ROUTE
    namespace :#{controller_name.underscore} do
      post 'email'
    end
ROUTE
    end
  end

  private
  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
  end

  def table_name
    model_name.tableize
  end

end
