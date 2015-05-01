class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.text :notes
      t.integer :client_id
      t.text :alerts
      t.string :url
      t.integer :calendar_id

      t.timestamps null: false
    end
  end
end
