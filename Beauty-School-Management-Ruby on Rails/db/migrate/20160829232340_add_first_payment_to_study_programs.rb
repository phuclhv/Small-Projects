class AddFirstPaymentToStudyPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :study_programs, :first_payment, :integer
  end
end
#
# StudyProgram.all.where(school_id: 1, id: 1).update_all(first_payment: 1000)
# StudyProgram.all.where(school_id: 1, id: 2).update_all(first_payment: 1000)
# StudyProgram.all.where(school_id: 1, id: 3).update_all(first_payment: 700)
# StudyProgram.all.where(school_id: 1, id: 5).update_all(first_payment: 1000)
# StudyProgram.all.where(school_id: 1, id: 7).update_all(first_payment: 800)
# StudyProgram.all.where(school_id: 1, id: 8).update_all(first_payment: 1000)

# StudyProgram.all.where(school_id: 2, id: 11).update_all(first_payment: 1000)
# StudyProgram.all.where(school_id: 2, id: 12).update_all(first_payment: 1000)
# StudyProgram.all.where(school_id: 2, id: 13).update_all(first_payment: 700)
# StudyProgram.all.where(school_id: 2, id: 15).update_all(first_payment: 1000)
# StudyProgram.all.where(school_id: 2, id: 17).update_all(first_payment: 800)
# StudyProgram.all.where(school_id: 2, id: 18).update_all(first_payment: 1000)