require 'launchy'

def visit_server(user: nil, wait: 2, path: '/')
  url = "http://#{Capybara.server_host}:#{Capybara.server_port}"

  url += if user.present?
           "/dev/log_in/#{user.id}?redirect_to=#{path}"
         else
           path
         end

  p "Visit server on: #{url}"
  Launchy.open(url)

  if wait == 0
    p 'Type any key to continue...'
    $stdin.gets
    p 'Done'
  else
    sleep wait
  end
end
