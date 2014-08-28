class SendgridWebhookCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      <%= migration_data -%>

      t.timestamps
    end

    add_index :<%= table_name %>, :school_id,              :unique => true
    add_index :<%= table_name %>, :user_id,                :unique => true
    # add_index :<%= table_name %>, [:recording_id, :recording_type],   :unique => true
  end
end
