class AddReferralBonusToPaymentConfig < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_configs, :referral_bonus_en, :integer, default: 0
    add_column :payment_configs, :referral_bonus_ru, :integer, default: 0
  end
end
