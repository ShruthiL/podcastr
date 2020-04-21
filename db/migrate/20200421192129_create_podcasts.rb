class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :name, null: false
      t.string :url, null: false, unique: true

      t.timestamps
    end
  end
end
