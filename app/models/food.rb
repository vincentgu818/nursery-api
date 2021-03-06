class Food
  if(ENV['DATABASE_URL'])
      uri = URI.parse(ENV['DATABASE_URL'])
      DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  else
      DB = PG.connect(host: "localhost", port: 5432, dbname: 'nursery-api_development')
  end

  def self.all
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM foods
        ORDER BY time DESC;
      SQL
    )
    return results.map do |result|
      {
        "id" => result["id"].to_i,
        "time" => result["time"],
        "food" => result["food"]
      }
    end
  end

  def self.find(id)
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM foods
        WHERE id=#{id}
        ORDER BY time DESC;
      SQL
    )
    result = results.first;
    return {
      "id" => result["id"].to_i,
      "time" => result["time"],
      "food" => result["food"]
    }
  end

  def self.create(opts)
    puts "OPTS", opts
    results = DB.exec(
      <<-SQL
        INSERT INTO foods (time, food)
        VALUES ( '#{opts["time"]}', '#{opts["food"]}' )
        RETURNING id, time, food;
      SQL
    )
    result = results.first
    return {
      "id" => result["id"].to_i,
      "time" => result["time"],
      "food" => result["food"]
    }
  end

  def self.delete(id)
    results = DB.exec("DELETE FROM foods WHERE id=#{id};")
    return { "deleted" => true }
  end

  def self.update(id, opts)
    puts "OPTS", opts
    results = DB.exec(
      <<-SQL
        UPDATE foods
        SET time='#{opts["time"]}', food='#{opts["food"]}'
        WHERE id=#{id}
        RETURNING id, time, food;
      SQL
    )
    result = results.first
    return {
      "id" => result["id"].to_i,
      "time" => result["time"],
      "food" => result["food"]
    }
  end
end
