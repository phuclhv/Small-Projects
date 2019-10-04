class StudyProgramsController < ApplicationController

  def show
    @study_program = StudyProgram.find(params[:id])
  end
end
