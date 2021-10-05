class CreateProxyServers < ActiveRecord::Migration[6.1]
  def change
    create_table :proxy_servers do |t|
      t.string :ip
      t.string :port
      t.timestamps
    end
  end
end
