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
        FROM feedings;
      SQL
    )
    return results.map do |result|
      {
        "id" => result["id"].to_i,
        "start_time" => result["start_time"],
        "end_time" => result["end_time"],
        "side" => result["side"]
      }
    end
  end

  def self.all_by_side(side)
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM feedings
        WHERE side='#{side.upcase}';
      SQL
    )
    return results.map do |result|
      {
        "id" => result["id"].to_i,
        "start_time" => result["start_time"],
        "end_time" => result["end_time"],
        "side" => result["side"]
      }
    end
  end

  def self.all_of_last_n_hours(n)
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM feedings
        WHERE end_time > (current_timestamp - interval '#{n} hours')
      SQL
    )
    return results.map do |result|
      {
        "id" => result["id"].to_i,
        "start_time" => result["start_time"],
        "end_time" => result["end_time"],
        "side" => result["side"]
      }
    end
  end

  def self.all_between_times(start,finish)
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM feedings
        WHERE end_time > '#{start[0..3]}-#{start[4..5]}-#{start[6..7]} #{start[8..9]}:#{start[10..11]}:#{start[12..13]}'
          AND start_time < '#{finish[0..3]}-#{finish[4..5]}-#{finish[6..7]} #{finish[8..9]}:#{finish[10..11]}:#{finish[12..13]}';
      SQL
    )
    return results.map do |result|
      {
        "id" => result["id"].to_i,
        "start_time" => result["start_time"],
        "end_time" => result["end_time"],
        "side" => result["side"]
      }
    end
  end

  def self.find(id)
    results = DB.exec(
      <<-SQL
        SELECT *
        FROM feedings
        WHERE id=#{id}
      SQL
    )
    result = results.first;
    return {
      "id" => result["id"].to_i,
      "start_time" => result["start_time"],
      "end_time" => result["end_time"],
      "side" => result["side"]
    }
  end

  def self.create(opts)
    puts "OPTS", opts
    results = DB.exec(
      <<-SQL
        INSERT INTO feedings (start_time, end_time, side)
        VALUES ( '#{opts["start_time"]}', '#{opts["end_time"]}', '#{opts["side"]}' )
        RETURNING id, start_time, end_time, side;
      SQL
    )
    result = results.first
    return {
      "id" => result["id"].to_i,
      "start_time" => result["start_time"],
      "end_time" => result["end_time"],
      "side" => result["side"]
    }
  end

  def self.delete(id)
    results = DB.exec("DELETE FROM feedings WHERE id=#{id};")
    return { "deleted" => true }
  end

  def self.update(id, opts)
    results = DB.exec(
      <<-SQL
        UPDATE feedings
        SET start_time='#{opts["start_time"]}', end_time='#{opts["end_time"]}', side='#{opts["side"]}'
        WHERE id=#{id}
        RETURNING id, start_time, end_time, side;
      SQL
    )
    result = results.first
    return {
      "id" => result["id"].to_i,
      "start_time" => result["start_time"],
      "end_time" => result["end_time"],
      "side" => result["side"]
    }
  end
end
