class Comment < ActiveRecord::Base
  attr_accessible :content, :commentable_id, :commentable_type, :author_id

  belongs_to :commentable, :polymorphic => true
  belongs_to :user, :foreign_key => "author_id"
end
