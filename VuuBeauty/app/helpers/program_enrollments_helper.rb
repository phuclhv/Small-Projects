module ProgramEnrollmentsHelper
  ENROLLMENT_STATUSES = { ACTIVE: 1, GRADUATED: 2, INACTIVE: 3, LOA: 4, TERMINATED: 5 }

  # Check if a user is a school user but not yet enrolled
  def enrolled?(user)
    school_user?(user) && 
      ProgramEnrollment.where(enrollment_status_id: ENROLLMENT_STATUSES[:ACTIVE], school_user_id: user.school_users.first.id).exists?
  end
end
