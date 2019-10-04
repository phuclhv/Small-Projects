class SchoolsController < ApplicationController
  def index
    @school = current_school_user.school
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
