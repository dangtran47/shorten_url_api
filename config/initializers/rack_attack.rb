class Rack::Attack
  cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('map_urls', limit: 10, period: 60) do |req|
    req.ip if req.path == '/map_urls' && req.post?
  end
end

Rack::Attack.throttled_response = lambda do |env|
  match_data = env['rack.attack.match_data']
  now = match_data[:epoch_time]

  headers = {
    'RateLimit-Limit' => match_data[:limit].to_s,
    'RateLimit-Remaining' => '0',
    'RateLimit-Reset' => (now + (match_data[:period] - now % match_data[:period])).to_s
  }

  [429, headers, [{ errors: { message: 'Please wait to make a new request.' } }.to_json]]
end
