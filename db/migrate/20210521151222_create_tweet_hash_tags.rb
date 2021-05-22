class CreateTweetHashTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_hash_tags do |t|
      t.belongs_to :tweet, index: true
      t.belongs_to :hash_tag, index: true

      t.timestamps
    end
  end
end
