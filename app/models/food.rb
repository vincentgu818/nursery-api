class Feeding
  DB = PG.connect({
    :host=> "localhost",
    :port => 5432,
    :dbname => 'nursery-api_development'
  })

  def self.all
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM foods;
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
