#
# New data need to be inserted at the bottome of this file.
#

School.create!(id: 1, name: "Vuu's Beauty School")
School.create!(id: 2, name: "Tim Beauty School")
School.create!(id: 3, name: "Beauty School Online")

StudyProgram.create!(id: 1, title: "Cosmetology", months: 12, tuition: 6000, school_id: 1)
StudyProgram.create!(id: 2, title: "Barber", months: 7, tuition: 5000, school_id: 1)
StudyProgram.create!(id: 3, title: "Manicurist", months: 6, tuition: 3000, school_id: 1)
StudyProgram.create!(id: 4, title: "Esthetician", months: 6, tuition: 4000, school_id: 1)
StudyProgram.create!(id: 5, title: "Instructor", months: 3, tuition: 5000, school_id: 1)
StudyProgram.create!(id: 7, title: "Esthetician2", months: 8, tuition: 3000, school_id: 1)
StudyProgram.create!(id: 8, title: "Hair Design", months: 12, tuition: 5000, school_id: 1)
#StudyProgram.create!(id: 6, title: "Employee", months: 12, tuition: 0, school_id: 1)

StudyProgram.create!(id: 11, title: "Cosmetology", months: 12, tuition: 6000, school_id: 2)
StudyProgram.create!(id: 12, title: "Barber", months: 7, tuition: 5000, school_id: 2)
StudyProgram.create!(id: 13, title: "Manicurist", months: 6, tuition: 3000, school_id: 2)
StudyProgram.create!(id: 15, title: "Instructor", months: 3, tuition: 5000, school_id: 2)
StudyProgram.create!(id: 17, title: "Esthetician", months: 8, tuition: 3000, school_id: 2)
StudyProgram.create!(id: 18, title: "Hair Design", months: 12, tuition: 5000, school_id: 2)

StudyProgram.create!(id: 21, title: "Cosmetology", months: 12, tuition: 6000, school_id: 3)
StudyProgram.create!(id: 22, title: "Barber", months: 7, tuition: 5000, school_id: 3)
StudyProgram.create!(id: 23, title: "Manicurist", months: 6, tuition: 3000, school_id: 3)
StudyProgram.create!(id: 25, title: "Instructor", months: 3, tuition: 5000, school_id: 3)
StudyProgram.create!(id: 27, title: "Esthetician", months: 8, tuition: 3000, school_id: 3)
StudyProgram.create!(id: 28, title: "Hair Design", months: 12, tuition: 5000, school_id: 3)

Race.create!(id: 1, description: "White/Caucasian")
Race.create!(id: 2, description: "Black/African American")
Race.create!(id: 3, description: "Hispanic")
Race.create!(id: 4, description: "American Indian or Alaska Native")
Race.create!(id: 5, description: "Asian")
Race.create!(id: 6, description: "Hawaiian Native or other Pacific Islander")
Race.create!(id: 7, description: "Multi-racial")
Race.create!(id: 8, description: "Other")

State.create!(id: 47, state: "WA", description: "Washington")

Activity.create!(id: 1, name: "Theory")
Activity.create!(id: 2, name: "Safety Sanitation")
Activity.create!(id: 3, name: "Diseases Disorders")
Activity.create!(id: 4, name: "First Aid")
Activity.create!(id: 5, name: "Facial")
Activity.create!(id: 6, name: "Temporary Removal Unwanted Hair")
Activity.create!(id: 7, name: "Extraction")
Activity.create!(id: 8, name: "Analysis Skin Care")
Activity.create!(id: 9, name: "Safety Sanitation First Aid")
Activity.create!(id: 10, name: "Shampoo Diseases Disorders")
Activity.create!(id: 11, name: "Hair Cutting Trimming")
Activity.create!(id: 12, name: "Wet Hair Styling")
Activity.create!(id: 13, name: "Cut Trim Facial Hair")
Activity.create!(id: 14, name: "Thermal Styling")
Activity.create!(id: 15, name: "Dry Hair Styling")
Activity.create!(id: 16, name: "Permanent Waving")
Activity.create!(id: 17, name: "Chemical Relaxer")
Activity.create!(id: 18, name: "Artificial Hair")
Activity.create!(id: 19, name: "Coloring and Styling")
Activity.create!(id: 20, name: "Manicure")
Activity.create!(id: 21, name: "Pedicure")
Activity.create!(id: 22, name: "Artificial Nail")
Activity.create!(id: 23, name: "Scalp Hair Analysis")
Activity.create!(id: 24, name: "Teaching Methods")
Activity.create!(id: 25, name: "Classroom Setup")
Activity.create!(id: 26, name: "Topic Subject Matter")
Activity.create!(id: 27, name: "Student Assignment")
Activity.create!(id: 28, name: "Materials Supplies")
Activity.create!(id: 29, name: "Record Keeping")
Activity.create!(id: 30, name: "Lectures")
Activity.create!(id: 31, name: "Demonstration")
Activity.create!(id: 32, name: "Questions Answers")
Activity.create!(id: 33, name: "Project Methods")
Activity.create!(id: 34, name: "Discussions")
Activity.create!(id: 35, name: "Clinic Supervision")
Activity.create!(id: 36, name: "Classroom Management")
Activity.create!(id: 37, name: "Client Relations")
Activity.create!(id: 38, name: "Written Practical Assessment")
Activity.create!(id: 39, name: "Communication Skills")
Activity.create!(id: 40, name: "Evaluation")
Activity.create!(id: 41, name: "Shampooing")
Activity.create!(id: 42, name: "Shaving")
Activity.create!(id: 43, name: "Manicure Pedicure")


EducationLevel.create!(id: 11, description: "Less than high school graduation")
EducationLevel.create!(id: 12, description: "GED")
EducationLevel.create!(id: 13, description: "High school graduate")
EducationLevel.create!(id: 14, description: "Some post high school, no degree or certificate")
EducationLevel.create!(id: 15, description: "Certificate (less than two years)")
EducationLevel.create!(id: 16, description: "Associate Degree")
EducationLevel.create!(id: 17, description: "Bachelors Degree")
EducationLevel.create!(id: 18, description: "Masters Degree")
EducationLevel.create!(id: 19, description: "Doctoral Degree or above")
EducationLevel.create!(id: 90, description: "Other")

SchoolUserType.create!(id: 1, description: "Student")
SchoolUserType.create!(id: 2, description: "Instructor")
SchoolUserType.create!(id: 3, description: "Admin")

# Vuu
ProgramRequirement.create!(hours:200, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 5,  study_program_id: 1)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 9,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 10,  study_program_id: 1)
ProgramRequirement.create!(hours:220, effective_date: Date.parse("01-JAN-00"), activity_id: 11,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 12,  study_program_id: 1)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 13,  study_program_id: 1)
ProgramRequirement.create!(hours:110, effective_date: Date.parse("01-JAN-00"), activity_id: 14,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 15,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 16,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 17,  study_program_id: 1)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 18,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 19,  study_program_id: 1)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 23,  study_program_id: 1)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 43,  study_program_id: 1)
ProgramRequirement.create!(hours:150, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 2)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 3,  study_program_id: 2)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 9,  study_program_id: 2)
ProgramRequirement.create!(hours:175, effective_date: Date.parse("01-JAN-00"), activity_id: 11,  study_program_id: 2)
ProgramRequirement.create!(hours:60, effective_date: Date.parse("01-JAN-00"), activity_id: 12,  study_program_id: 2)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 13,  study_program_id: 2)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 14,  study_program_id: 2)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 15,  study_program_id: 2)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 18,  study_program_id: 2)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 23,  study_program_id: 2)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 41,  study_program_id: 2)
ProgramRequirement.create!(hours:70, effective_date: Date.parse("01-JAN-00"), activity_id: 42,  study_program_id: 2)
ProgramRequirement.create!(hours:80, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 3)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 2,  study_program_id: 3)
ProgramRequirement.create!(hours:80, effective_date: Date.parse("01-JAN-00"), activity_id: 3,  study_program_id: 3)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 4,  study_program_id: 3)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 20,  study_program_id: 3)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 21,  study_program_id: 3)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 22,  study_program_id: 3)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 4)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 2,  study_program_id: 4)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 3,  study_program_id: 4)
ProgramRequirement.create!(hours:25, effective_date: Date.parse("01-JAN-00"), activity_id: 4,  study_program_id: 4)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 5,  study_program_id: 4)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 6,  study_program_id: 4)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 7,  study_program_id: 4)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 8,  study_program_id: 4)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 24,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 25,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 26,  study_program_id: 5)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 27,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 28,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 29,  study_program_id: 5)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 30,  study_program_id: 5)
ProgramRequirement.create!(hours:30, effective_date: Date.parse("01-JAN-00"), activity_id: 31,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 32,  study_program_id: 5)
ProgramRequirement.create!(hours:40, effective_date: Date.parse("01-JAN-00"), activity_id: 33,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 34,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 35,  study_program_id: 5)
ProgramRequirement.create!(hours:30, effective_date: Date.parse("01-JAN-00"), activity_id: 36,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 37,  study_program_id: 5)
ProgramRequirement.create!(hours:30, effective_date: Date.parse("01-JAN-00"), activity_id: 38,  study_program_id: 5)
ProgramRequirement.create!(hours:40, effective_date: Date.parse("01-JAN-00"), activity_id: 39,  study_program_id: 5)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 40,  study_program_id: 5)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 1,  study_program_id: 7)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 2,  study_program_id: 7)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 3,  study_program_id: 7)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("25-MAR-14"), activity_id: 4,  study_program_id: 7)
ProgramRequirement.create!(hours:150, effective_date: Date.parse("25-MAR-14"), activity_id: 5,  study_program_id: 7)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 6,  study_program_id: 7)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("25-MAR-14"), activity_id: 7,  study_program_id: 7)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 8,  study_program_id: 7)
ProgramRequirement.create!(hours:200, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 8)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 9,  study_program_id: 8)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 10,  study_program_id: 8)
ProgramRequirement.create!(hours:220, effective_date: Date.parse("01-JAN-00"), activity_id: 11,  study_program_id: 8)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 12,  study_program_id: 8)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 13,  study_program_id: 8)
ProgramRequirement.create!(hours:110, effective_date: Date.parse("01-JAN-00"), activity_id: 14,  study_program_id: 8)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 15,  study_program_id: 8)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 16,  study_program_id: 8)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 17,  study_program_id: 8)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 18,  study_program_id: 8)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 19,  study_program_id: 8)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 23,  study_program_id: 8)

# Beauty School Online
ProgramRequirement.create!(hours:200, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 5,  study_program_id: 21)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 9,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 10,  study_program_id: 21)
ProgramRequirement.create!(hours:220, effective_date: Date.parse("01-JAN-00"), activity_id: 11,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 12,  study_program_id: 21)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 13,  study_program_id: 21)
ProgramRequirement.create!(hours:110, effective_date: Date.parse("01-JAN-00"), activity_id: 14,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 15,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 16,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 17,  study_program_id: 21)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 18,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 19,  study_program_id: 21)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 23,  study_program_id: 21)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 43,  study_program_id: 21)
ProgramRequirement.create!(hours:150, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 22)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 3,  study_program_id: 22)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 9,  study_program_id: 22)
ProgramRequirement.create!(hours:175, effective_date: Date.parse("01-JAN-00"), activity_id: 11,  study_program_id: 22)
ProgramRequirement.create!(hours:60, effective_date: Date.parse("01-JAN-00"), activity_id: 12,  study_program_id: 22)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 13,  study_program_id: 22)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 14,  study_program_id: 22)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 15,  study_program_id: 22)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 18,  study_program_id: 22)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 23,  study_program_id: 22)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 41,  study_program_id: 22)
ProgramRequirement.create!(hours:70, effective_date: Date.parse("01-JAN-00"), activity_id: 42,  study_program_id: 22)
ProgramRequirement.create!(hours:80, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 23)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 2,  study_program_id: 23)
ProgramRequirement.create!(hours:80, effective_date: Date.parse("01-JAN-00"), activity_id: 3,  study_program_id: 23)
ProgramRequirement.create!(hours:75, effective_date: Date.parse("01-JAN-00"), activity_id: 4,  study_program_id: 23)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 20,  study_program_id: 23)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 21,  study_program_id: 23)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 22,  study_program_id: 23)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 24,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 25,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 26,  study_program_id: 25)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 27,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 28,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 29,  study_program_id: 25)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 30,  study_program_id: 25)
ProgramRequirement.create!(hours:30, effective_date: Date.parse("01-JAN-00"), activity_id: 31,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 32,  study_program_id: 25)
ProgramRequirement.create!(hours:40, effective_date: Date.parse("01-JAN-00"), activity_id: 33,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 34,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 35,  study_program_id: 25)
ProgramRequirement.create!(hours:30, effective_date: Date.parse("01-JAN-00"), activity_id: 36,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 37,  study_program_id: 25)
ProgramRequirement.create!(hours:30, effective_date: Date.parse("01-JAN-00"), activity_id: 38,  study_program_id: 5)
ProgramRequirement.create!(hours:40, effective_date: Date.parse("01-JAN-00"), activity_id: 39,  study_program_id: 25)
ProgramRequirement.create!(hours:20, effective_date: Date.parse("01-JAN-00"), activity_id: 40,  study_program_id: 25)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 1,  study_program_id: 27)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 2,  study_program_id: 27)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 3,  study_program_id: 27)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("25-MAR-14"), activity_id: 4,  study_program_id: 27)
ProgramRequirement.create!(hours:150, effective_date: Date.parse("25-MAR-14"), activity_id: 5,  study_program_id: 27)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 6,  study_program_id: 27)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("25-MAR-14"), activity_id: 7,  study_program_id: 27)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("25-MAR-14"), activity_id: 8,  study_program_id: 27)
ProgramRequirement.create!(hours:200, effective_date: Date.parse("01-JAN-00"), activity_id: 1,  study_program_id: 28)
ProgramRequirement.create!(hours:120, effective_date: Date.parse("01-JAN-00"), activity_id: 9,  study_program_id: 28)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 10,  study_program_id: 28)
ProgramRequirement.create!(hours:220, effective_date: Date.parse("01-JAN-00"), activity_id: 11,  study_program_id: 28)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 12,  study_program_id: 28)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 13,  study_program_id: 28)
ProgramRequirement.create!(hours:110, effective_date: Date.parse("01-JAN-00"), activity_id: 14,  study_program_id: 28)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 15,  study_program_id: 28)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 16,  study_program_id: 28)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 17,  study_program_id: 28)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 18,  study_program_id: 28)
ProgramRequirement.create!(hours:100, effective_date: Date.parse("01-JAN-00"), activity_id: 19,  study_program_id: 28)
ProgramRequirement.create!(hours:50, effective_date: Date.parse("01-JAN-00"), activity_id: 23,  study_program_id: 28)

EnrollmentStatus.create!(description: "Active")
EnrollmentStatus.create!(description: "Graduated")
EnrollmentStatus.create!(description: "Inactive")
EnrollmentStatus.create!(description: "Leave of absence")
EnrollmentStatus.create!(description: "Terminated")

PaymentType.create!(id: 1, description: "Cash")
PaymentType.create!(id: 2, description: "Check")
PaymentType.create!(id: 3, description: "Credit card")
PaymentType.create!(id: 4, description: "Coupon")
PaymentType.create!(id: 5, description: "Testing kit deposit")

# Vuu:
OperationRule.create!(day_of_week_closed: "Sunday", open_hour:  10, open_minute:  30, tz: 'Pacific Time (US & Canada)',
                                                    close_hour: 18, close_minute: 30, school_id: 1)
# Tim:
OperationRule.create!(day_of_week_closed: "Sunday", open_hour:  10, open_minute:  30, tz: 'Pacific Time (US & Canada)',
                                                    close_hour: 18, close_minute: 30, school_id: 2)

User.create!(first_name:  "David", last_name: "Nguyen",
             email:                 "davidnhg@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Create a school admin for Vuu
User.create!(first_name:  "David", last_name: "N",
             email:                 "davidnhg@yahoo.com",
             password:              "password",
             password_confirmation: "password",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)
SchoolUser.create!(
              ssn: "555-22-4444",
              dob: "12/21/1977",
              school_user_type_id: 3,
              race_id: 5,
              education_level_id: 11,
              user_id: 2,
              school_id: 1)

# Create a school student for Vuu
User.create!(first_name:  "Lily", last_name: "Nguyen",
             email:                 "lily@yahoo.com",
             password:              "password",
             password_confirmation: "password",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)
SchoolUser.create!(
              ssn: "111-22-4444",
              dob: "12/21/1990",
              school_user_type_id: 1,
              race_id: 5,
              education_level_id: 11,
              user_id: 3,
              school_id: 1)

User.create!(first_name:  "Example", last_name: "User",
             email: "example@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

User.create!(first_name:  "E2", last_name: "User",
             email: "e2@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)


20.times do |n|
  full_name = Faker::Name.name
  first_name  = full_name.split(" ")[0]
  last_name  =  full_name.split(" ")[1]
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name:  first_name, last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Generate data for Calendar
#d = Date.new(2010, 1, 1) # Vuu migration
d = Date.new(2016, 7, 1)

70.times do |n|
  d = d + n
  id = n + 1
  Calendar.create!(id: id, day: d.day, day_of_week: d.strftime("%A"), month: d.month, year: d.year)
end

=begin
>> d = Time.now
=> 2016-07-26 22:59:09 +0000
>> d
=> 2016-07-26 22:59:09 +0000
>> start = Time.new(2016, 7, 26, 10, 30, 0)
=> 2016-07-26 10:30:00 +0000
>> stop = Time.new(2016, 7, 26, 18, 30, 0)
=> 2016-07-26 18:30:00 +0000
>> if (start..stop).cover? d

Time zone:

?> Time.zone.now
=> Tue, 26 Jul 2016 23:14:45 UTC +00:00
>> now = Time.zone.now
=> Tue, 26 Jul 2016 23:14:54 UTC +00:00
>> now.in_time_zone('Eastern Time (US & Canada)')
=> Tue, 26 Jul 2016 19:14:54 EDT -04:00
>> now.in_time_zone('Pacific Time (US & Canada)')                                                                                   
=> Tue, 26 Jul 2016 16:14:54 PDT -07:00
=end