# Description
An application to manage a beauty school enrollment

# Ruby on Rails Tutorial sample application

This is the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

```
$ bundle exec guard
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

```
$ rails generate controller StaticPages home help
```

```
$ rails destroy  controller StaticPages home help
```

Similarly, in Chapter 6 we’ll generate a model as follows:

```
$ rails generate model User name:string email:string
$ rails g model PaymentType description:string
```

This can be undone using

```
$ rails destroy model User
```

```
$ rails db:migrate
```

We can undo a single migration step using

```
$ rails db:rollback
```

To go all the way back to the beginning, we can use

```
$ rails db:migrate VERSION=0
```

Code	Matching HTML
assert_select "div"	<div>foobar</div>
assert_select "div", "foobar"	<div>foobar</div>
assert_select "div.nav"	<div class="nav">foobar</div>
assert_select "div#profile"	<div id="profile">foobar</div>
assert_select "div[name=yo]"	<div name="yo">hey</div>
assert_select "a[href=?]", ’/’, count: 1	<a href="/">foo</a>
assert_select "a[href=?]", ’/’, text: "foo"	<a href="/">foo</a>
Table 5.2: Some uses of assert_select.

Auto session timeout:  http://madkingsmusings.blogspot.com/2011/05/session-timeouts-on-rails.html

Add FK where Study_Program is child of School:

```
rails  g migration add_school_to_study_programs school:references
```

```
rails destroy migration add_tz_to_schools tz:string 
```

Reset database and seed it again:
```
$ rails db:migrate:reset
$ rails db:seed
```

On heroku:

```
$ heroku pg:reset
$ heroku run rails db:migrate
$ heroku run rails db:seed
```

Check any non-merged branch:
```
$ git branch --no-merged master
```
Set up postgres on Cloud9:
```
https://github.com/Aerogami/guides/wiki/Cloud9-workspace-setup-with-Rails-and-Postgresql
```
Good read on extra fields, i.e. not in model, on a form:
http://stackoverflow.com/questions/30201277/rails-4-how-do-you-make-date-select-form-field-helper-required

How to pass ID around:
```
<%= link_to upload_path(id: lesson.id), remote: true, method: :post do %>
    <button class="class: "btn btn-lg btn-primary"">Upload</button>
<% end %>
```
To do:
```
1.  Refactor filename in Lessons controller
2.  Because we add EnrollmentStatusID to ProgramEnrollment, we need to fix other places.
3.  Esthetician:  no lesson assiged to student crashed! ==> probably nil somewhere in erb
4.  pe=ProgramEnrollment.new(online: true, study_program_id: 7, enrollment_status_id: 1, contract_agreement: true, tuition_balance: 3000, school_user_id: 12, enrollment_date: Time.zone.now)
5.  Add online certs:
sp=StudyProgram.new(id: 19, title: "Online Cosmetology Certificate", months: 4, tuition: 1500, school_id: 1, required_hours: 400, online_hours: 400)
sp=StudyProgram.new(id: 20, title: "Online Barber Certificate", months: 4, tuition: 1000, school_id: 1, required_hours: 250, online_hours: 250)
sp=StudyProgram.new(id: 21, title: "Online Manicurist Certificate", months: 4, tuition: 500, school_id: 1, required_hours: 150, online_hours: 150)
sp=StudyProgram.new(id: 22, title: "Online Instructor Certificate", months: 4, tuition: 1000, school_id: 1, required_hours: 125, online_hours: 125)
sp=StudyProgram.new(id: 23, title: "Online Esthetician Certificate", months: 4, tuition: 700, school_id: 1, required_hours: 187, online_hours: 187)
sp=StudyProgram.new(id: 24, title: "Online Hair Design Certificate", months: 4, tuition: 1200, school_id: 1, required_hours: 350, online_hours: 350)



```

Cool stuff:  Get the text content of a button:
```
http://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_node_textcontent
```

See Scribd to view docs from Scribd:
```
https://www.scribd.com/developers/platform
```

Datafix:
@students = SchoolUser.all.where(school_id: 1).joins(:program_enrollments)
@students.each do |s|
  pe = ProgramEnrollment.find_by(school_user_id: s.id)
  @shs = StudentHourSummary.all.where(school_user_id: pe.school_user_id).first
  @program_requirements = pe.study_program.program_requirements.where.not(activity_id: @shs.activity_id)
  @program_requirements.each do |pr|
    @shs1 = StudentHourSummary.new(activity_id: pr.activity_id, school_user_id: @shs.school_user_id, month: @shs.month, year: @shs.year, monthly_total: 0, to_date_total: 0, remaining_required: pr.hours, previous_to_date_total: 0)
    @shs1.save
  end
end

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).

Adding Date column to Calendar table and backfill:
```
@calendars = Calendar.order(:id)
@calendars.each do |cal|
  cal.update_columns(date: DateTime.parse(cal.day.to_s + "/" + cal.month.to_s + "/" + cal.year.to_s))
end
```
