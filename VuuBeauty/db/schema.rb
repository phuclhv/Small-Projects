# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161202051138) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.integer  "user_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.integer  "day"
    t.string   "day_of_week"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "date"
  end

  create_table "education_levels", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "enrollment_statuses", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "exam_results", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "score"
    t.string   "answers"
    t.integer  "student_lesson_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["student_lesson_id"], name: "index_exam_results_on_student_lesson_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string   "document_path"
    t.integer  "lesson_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["lesson_id"], name: "index_exams_on_lesson_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "chapter_number"
    t.string   "chapter_name"
    t.integer  "lesson_number"
    t.string   "lesson_name"
    t.string   "book_name"
    t.integer  "page_number"
    t.integer  "study_program_id"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "document_name"
    t.string   "document_path"
    t.string   "sys_doc_name",     default: "vvjwg6BNkMN8-a05BogwUA"
    t.index ["study_program_id"], name: "index_lessons_on_study_program_id"
  end

  create_table "operation_rules", force: :cascade do |t|
    t.string   "day_of_week_closed"
    t.integer  "open_hour"
    t.integer  "open_minute"
    t.integer  "close_hour"
    t.integer  "close_minute"
    t.integer  "school_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "tz"
    t.index ["school_id"], name: "index_operation_rules_on_school_id"
  end

  create_table "payment_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "amount"
    t.date     "payment_date"
    t.integer  "school_user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "stripe_customer_id"
    t.integer  "payment_type_id"
    t.index ["payment_type_id"], name: "index_payments_on_payment_type_id"
    t.index ["school_user_id"], name: "index_payments_on_school_user_id"
  end

  create_table "program_enrollments", force: :cascade do |t|
    t.datetime "enrollment_date"
    t.datetime "graduation_date"
    t.boolean  "brochure_received",    default: true
    t.decimal  "gpa"
    t.integer  "tuition_balance"
    t.datetime "status_change_date"
    t.boolean  "transferred",          default: false
    t.boolean  "online",               default: false
    t.integer  "school_user_id"
    t.integer  "study_program_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "enrollment_status_id"
    t.boolean  "contract_agreement"
    t.index ["enrollment_status_id"], name: "index_program_enrollments_on_enrollment_status_id"
    t.index ["school_user_id"], name: "index_program_enrollments_on_school_user_id"
    t.index ["study_program_id"], name: "index_program_enrollments_on_study_program_id"
  end

  create_table "program_requirements", force: :cascade do |t|
    t.integer  "hours"
    t.date     "effective_date"
    t.date     "end_date"
    t.integer  "study_program_id"
    t.integer  "activity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["activity_id"], name: "index_program_requirements_on_activity_id"
    t.index ["study_program_id"], name: "index_program_requirements_on_study_program_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "question_number"
    t.string   "answer_key"
    t.integer  "exam_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "question_name"
    t.boolean  "your_answer"
    t.index ["exam_id"], name: "index_questions_on_exam_id"
  end

  create_table "races", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "school_user_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "school_users", force: :cascade do |t|
    t.string   "ssn"
    t.date     "dob"
    t.string   "gender"
    t.boolean  "disability",          default: false
    t.boolean  "veteran",             default: false
    t.boolean  "newsletter",          default: false
    t.integer  "appid"
    t.integer  "school_user_type_id"
    t.integer  "race_id"
    t.integer  "education_level_id"
    t.integer  "user_id"
    t.integer  "school_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["education_level_id"], name: "index_school_users_on_education_level_id"
    t.index ["race_id"], name: "index_school_users_on_race_id"
    t.index ["school_id"], name: "index_school_users_on_school_id"
    t.index ["school_user_type_id"], name: "index_school_users_on_school_user_type_id"
    t.index ["user_id"], name: "index_school_users_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "email"
  end

  create_table "states", force: :cascade do |t|
    t.string   "state"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "student_hour_summaries", force: :cascade do |t|
    t.integer  "month"
    t.integer  "year"
    t.float    "monthly_total"
    t.float    "to_date_total"
    t.float    "remaining_required"
    t.float    "previous_to_date_total"
    t.integer  "activity_id"
    t.integer  "school_user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["activity_id"], name: "index_student_hour_summaries_on_activity_id"
    t.index ["school_user_id"], name: "index_student_hour_summaries_on_school_user_id"
  end

  create_table "student_hours", force: :cascade do |t|
    t.float    "daily_hour"
    t.boolean  "processed",      default: false
    t.integer  "calendar_id"
    t.integer  "activity_id"
    t.integer  "timecard_id"
    t.integer  "school_user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["activity_id"], name: "index_student_hours_on_activity_id"
    t.index ["calendar_id"], name: "index_student_hours_on_calendar_id"
    t.index ["school_user_id"], name: "index_student_hours_on_school_user_id"
    t.index ["timecard_id"], name: "index_student_hours_on_timecard_id"
  end

  create_table "student_lessons", force: :cascade do |t|
    t.boolean  "visible",        default: false
    t.boolean  "enabled",        default: false
    t.boolean  "completed",      default: false
    t.integer  "taken_order"
    t.integer  "school_user_id"
    t.integer  "lesson_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["lesson_id"], name: "index_student_lessons_on_lesson_id"
    t.index ["school_user_id", "lesson_id", "taken_order"], name: "student_lessons_user_lesson_taken_uniq", unique: true
    t.index ["school_user_id"], name: "index_student_lessons_on_school_user_id"
  end

  create_table "study_programs", force: :cascade do |t|
    t.string   "title"
    t.integer  "months"
    t.integer  "tuition"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "school_id"
    t.integer  "required_hours"
    t.integer  "online_hours"
    t.integer  "first_payment"
    t.integer  "monthly_payment"
    t.index ["school_id"], name: "index_study_programs_on_school_id"
  end

  create_table "timecards", force: :cascade do |t|
    t.datetime "clock_in",                       null: false
    t.datetime "clock_out"
    t.boolean  "processed",      default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "school_user_id"
    t.integer  "calendar_id"
    t.index ["calendar_id"], name: "index_timecards_on_calendar_id"
    t.index ["school_user_id"], name: "index_timecards_on_school_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
