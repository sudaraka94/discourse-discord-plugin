# name: discourse-discord-plugin
# about: A plugin for syncing the users between a discourse instance and Discord.
# version: 1.0
# authors: Sudaraka
# url: https://github.com/sudaraka94/discourse-discord-plugin

after_initialize do
  require_dependency File.expand_path('../lib/discourse_discord.rb', __FILE__)
  require_dependency File.expand_path('../lib/util.rb', __FILE__)

  # Add event hook to username update
   User.class_eval do
     after_save do |user|
       if user.id > 0
         DiscourseEvent.trigger(:username_updated, user)
       end
     end
   end

   # Sync users on badge grnat
   DiscourseEvent.on(:user_badge_granted) do |badge_id, user_id|
     user = User.find(user_id)
     Util.sync_user(user)
   end

   # Sync users on create and update
   DiscourseEvent.on(:username_updated) do |user|
     Util.sync_user(user)
   end
end
