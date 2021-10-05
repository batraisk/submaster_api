class CreateReferralInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :referral_invitations do |t|
      t.string :recipient_email
      t.string :status, null: false, default: 'created'
      t.integer :bonus
      t.string :access_token

      t.references :sender, null: false, foreign_key: { to_table: 'users' }
      t.references :recipient, null: true, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
