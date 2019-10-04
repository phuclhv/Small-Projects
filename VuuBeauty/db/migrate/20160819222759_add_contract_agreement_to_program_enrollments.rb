class AddContractAgreementToProgramEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_column :program_enrollments, :contract_agreement, :boolean
  end
end
