# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Relationship < ActiveRecord::Base
  
  # -- Allowing access to :followed_id lets us build instance methods
  # -- like this: user.relationships.find_by_followed_id()
  # NOTE: find_by_followed_id() either returns an instance of the Relationship class or nil
  
  # -- A good question to ask when deciding whether or not to 
  # -- make an attribute accessible is "Would I need to build a
  # -- query with this attribute?"
  attr_accessible :followed_id

  # -- Why do we need to be explicit about the Relationship's association
  # -- to the User class?
  # -- A relationship belongs to the two users who define the relationship.
  # -- (Remember to define the association from the User class perspective.) 

  # -- Please note the following custom-named instance methods that return User objects.
  # --  -- We're mapping both :follower and :followed to the User class
  # --  -- so that follower_id(1) == User.id(1) AND follwed_id(1) == User.id(1)
  # --  -- When we call follower on a Relationship object, it returns the User object, whereas if
  # --  -- we call relationship.follower_id, it only returns the ID value.
   belongs_to :follower, class_name: "User"
   belongs_to :followed, class_name: "User"

   # -- Simple validation on both indexed ID fields.
   validates :follower_id, presence: true
   validates :followed_id, presence: true
end
