class SendgridWebhookCreate<%= model_name.camelize %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.integer  "school_id"
      t.integer  "user_id"
      t.text     "status"
      t.string   "subject"
      t.text     "body"
      t.string   "from"
      t.text     "to"
      # t.integer  "recording_id"
      # t.string   "recording_type"
      t.timestamps
    end

    add_index :<%= table_name %>, :school_id,              :unique => true
    add_index :<%= table_name %>, :user_id,                :unique => true
    # add_index :<%= table_name %>, [:recording_id, :recording_type],   :unique => true
  end
end
