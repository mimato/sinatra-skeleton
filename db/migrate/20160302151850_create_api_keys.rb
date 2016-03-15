class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references  :user,        null: false
      t.string      :name,        null: false
      t.string      :identifier,  null: false, index: true, uniqueness: true
      t.string      :password_hash
    end
  end
end
