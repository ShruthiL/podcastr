class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :podcasts, :url, unique: true    
  end
end
