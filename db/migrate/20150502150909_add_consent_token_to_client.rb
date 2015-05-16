class AddConsentTokenToClient < ActiveRecord::Migration
  def change
    add_column :clients, :consent_token, :string
  end
end
