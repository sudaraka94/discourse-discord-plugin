class DiscourseDiscord
  def self.add_role(guild_id, user_id, role_id)
    discord_host = SiteSetting.discord_host
    response = Faraday.put do |req|
      req.url "#{discord_host}/guilds/#{guild_id}/members/#{user_id}/roles/#{role_id}"
    end

    begin
      parsed_response=JSON.parse response.body
      if parsed_response["status"] == "error"
        Rails.logger.error "DISCOURSE DISCORD PLUGIN :: Asigning user role failed with error: #{parsed_response['message']}"
      end
    rescue
      Rails.logger.error "DISCOURSE DISCORD PLUGIN :: Asigning user role failed while parsing the response"
    end
  end

  def self.remove_role(guild_id, user_id, role_id)
    discord_host = SiteSetting.discord_host
    response = Faraday.delete do |req|
      req.url "#{discord_host}/guilds/#{guild_id}/members/#{user_id}/roles/#{role_id}"
    end

    begin
      parsed_response=JSON.parse response.body
      if parsed_response["status"] == "error"
        Rails.logger.error "DISCOURSE DISCORD PLUGIN :: Asigning user role failed with error: #{parsed_response['message']}"
      end
    rescue
      Rails.logger.error "DISCOURSE DISCORD PLUGIN :: Asigning user role failed while parsing the response"
    end
  end
end
