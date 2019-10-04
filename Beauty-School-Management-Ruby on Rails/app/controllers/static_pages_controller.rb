class StaticPagesController < ApplicationController
  def home
    @study_programs = StudyProgram.where("school_id = ? and id != ?", 1, 4)
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
