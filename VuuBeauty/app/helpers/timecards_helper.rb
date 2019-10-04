module TimecardsHelper
  
  # Checks for existence of a timecard
  def timecard_any?(school_user)
    school_user?(school_user) && school_user.timecards.any?
  end
  
  # Checks if school_user is currently clocked in and has not been clocked out yet.
  def currently_clocked_in?(school_user)
    if timecard_any?(school_user)
      school_user.timecards.first.clock_out.nil?
    else
      false
    end
  end

  # Students can clockin/clockout during school hours only.
  def school_hour?(school_user)
    operation_rules = school_user.school.operation_rules
    if (operation_rules.exists?)
      op_rule = operation_rules.first
      now = Time.zone.now.in_time_zone(op_rule.tz)
      start_time = Time.new(now.year, now.month, now.day, op_rule.open_hour,  op_rule.open_minute,  0)
      end_time   = Time.new(now.year, now.month, now.day, op_rule.close_hour, op_rule.close_minute, 0)
      now = Time.new(now.year, now.month, now.day, now.hour, now.min, 0)
      if ( now.strftime("%A") != op_rule.day_of_week_closed && ((start_time..end_time).cover? now) )
        true
      else
        false
      end
    else
      true
    end
  end
end