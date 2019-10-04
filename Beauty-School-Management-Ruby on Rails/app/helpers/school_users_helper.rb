module SchoolUsersHelper
  SCHOOL_USERS = { student: 1, instructor: 2, admin: 3 }
  
  # Log in school user
  def log_in_school_user(user)
    session[:school_user_id] = user.school_users.find_by(user_id: user.id).id
  end
  
  # Log out school user
  def log_out_school_user
    session.delete(:school_user_id)
    @current_school_user = nil
  end
  
  # Check if a user is a school user
  def school_user?(user)
    SchoolUser.exists?(user_id: user.id)
  end

  # Confirms a school admin.
  def school_admin?(user)
    SchoolUser.exists?(user_id: user.id, school_user_type_id: SCHOOL_USERS[:admin])
  end

  # Confirms an school admin user.
  def school_admin
    redirect_to(root_url) unless school_admin?(current_user)
  end

  # Confirms an instructor.
  def instructor?(user)
    SchoolUser.exists?(user_id: user.id, school_user_type_id: SCHOOL_USERS[:instructor])
  end

  # Confirms a student.
  def student?(user)
    SchoolUser.exists?(user_id: user.id, school_user_type_id: SCHOOL_USERS[:student])
  end

  # Returns the school user corresponding to the remember token cookie.
  def current_school_user
    if logged_in?
      school_user_id = session[:school_user_id]
      if !(school_user_id)
        log_in_school_user(current_user)
        school_user_id = session[:school_user_id]
      end
      @current_school_user ||= SchoolUser.find(school_user_id)
    end
  end

  # Returns true if the given user is the current school user.
  def current_school_user?(user)
    user.school_users.where(user_id: user.id) == current_school_user
  end
end
