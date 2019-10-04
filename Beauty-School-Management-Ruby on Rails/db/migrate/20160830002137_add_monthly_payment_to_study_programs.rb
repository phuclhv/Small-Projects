class AddMonthlyPaymentToStudyPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :study_programs, :monthly_payment, :integer
  end
end

#StudyProgram.all.where(school_id: [1, 2]).update_all(monthly_payment: 300)