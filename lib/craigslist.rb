module Craigslist

  def self.get_and_retry(mechanize, uri, retries = 3)
    mechanize.get(uri)
  rescue => e
    raise e if retries == 0
    retries -= 1
    $stderr.puts "Error connecting: #{e}. Retrying"
    retry
  end
  
  def self.process_path(path)
    path = remove_query(path)
    path = remove_search(path)
    path = remove_beginning_slash(path)
    remove_trailing_slash(path)
  end
  
  def self.remove_search(path)
    path.sub(/search\//, '')
  end
  
  def self.remove_beginning_slash(path)
    path.sub(/^\//,'')
  end
  
  def self.remove_trailing_slash(path)
    path.sub(/\/$/,'')
  end
  
  # Some paths have queries that need to be removed before they can be
  # added to the database
  def self.remove_query(path)
    path = URI(path)
    path.query = nil
    path.to_s
  end
end
