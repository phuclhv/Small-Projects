class AddSysDocNameToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :sys_doc_name, :string, default: User.new_token
  end
end
