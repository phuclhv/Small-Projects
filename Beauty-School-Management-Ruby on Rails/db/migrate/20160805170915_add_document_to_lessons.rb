class AddDocumentToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :document_name, :string
    add_column :lessons, :document_path, :string
  end
end
