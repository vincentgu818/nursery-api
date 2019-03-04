class Feeding
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'nursery-api_development')
    end

  def self.all
    results = DB.exec(
      <<-SQL
        SELECT
          feedings.*,
          feedings.end_time-feedings.start_time AS duration,
          foods.food
        FROM feedings LEFT JOIN foods
          ON time>(start_time-interval '6 hours')
          AND time<(start_time-interval '1 hour')
        ORDER BY start_time DESC;
      SQL
    )

    feedings = []
    last_feeding_id = nil
    results.each do |result|
      if result["id"] != last_feeding_id
        duration = result["duration"][0..1].to_i*3600000+result["duration"][3..4].to_i*60000+result["duration"][6..7].to_i*1000
        feedings << {
          "id" => result["id"].to_i,
          "start_time" => result["start_time"],
          "end_time" => result["end_time"],
          "duration" => duration,
          "side" => result["side"],
          "foods" => []
        }
      end
      if result["food"]
        feedings.last["foods"] << result["food"]
      end
      last_feeding_id = result["id"]
    end

    return feedings
  end

  def self.all_by_side(side)
    results = DB.exec(
      <<-SQL
        SELECT
          feedings.*,
          feedings.end_time-feedings.start_time AS duration,
          foods.food
        FROM feedings LEFT JOIN foods
          ON time>(start_time-interval '6 hours')
          AND time<(start_time-interval '1 hour')
        WHERE side='#{side.upcase}'
        ORDER BY start_time DESC;
      SQL
    )

    feedings = []
    last_feeding_id = nil
    results.each do |result|
      if result["id"] != last_feeding_id
        duration = result["duration"][0..1].to_i*3600000+result["duration"][3..4].to_i*60000+result["duration"][6..7].to_i*1000
        feedings << {
          "id" => result["id"].to_i,
          "start_time" => result["start_time"],
          "end_time" => result["end_time"],
          "duration" => duration,
          "side" => result["side"],
          "foods" => []
        }
      end
      if result["food"]
        feedings.last["foods"] << result["food"]
      end
      last_feeding_id = result["id"]
    end

    return feedings
  end

  def self.all_of_last_n_hours(n)
    results = DB.exec(
        <<-SQL
        SELECT
          feedings.*,
          feedings.end_time-feedings.start_time AS duration,
          foods.food
        FROM feedings LEFT JOIN foods
          ON time>(start_time-interval '6 hours')
          AND time<(start_time-interval '1 hour')
        WHERE end_time > (current_timestamp - interval '#{n} hours')
        ORDER BY start_time DESC;
      SQL
    )

    feedings = []
    last_feeding_id = nil
    results.each do |result|
      if result["id"] != last_feeding_id
        duration = result["duration"][0..1].to_i*3600000+result["duration"][3..4].to_i*60000+result["duration"][6..7].to_i*1000
        feedings << {
          "id" => result["id"].to_i,
          "start_time" => result["start_time"],
          "end_time" => result["end_time"],
          "duration" => duration,
          "side" => result["side"],
          "foods" => []
        }
      end
      if result["food"]
        feedings.last["foods"] << result["food"]
      end
      last_feeding_id = result["id"]
    end

    return feedings
  end

  def self.all_between_times(start,finish)
    results = DB.exec(
      <<-SQL
        SELECT
          feedings.*,
          feedings.end_time-feedings.start_time AS duration,
          foods.food
        FROM feedings LEFT JOIN foods
          ON time>(start_time-interval '6 hours')
          AND time<(start_time-interval '1 hour')
        WHERE end_time > '#{start[0..3]}-#{start[4..5]}-#{start[6..7]} #{start[8..9]}:#{start[10..11]}:#{start[12..13]}'
          AND start_time < '#{finish[0..3]}-#{finish[4..5]}-#{finish[6..7]} #{finish[8..9]}:#{finish[10..11]}:#{finish[12..13]}'
        ORDER BY start_time DESC;
      SQL
    )

    feedings = []
    last_feeding_id = nil
    results.each do |result|
      if result["id"] != last_feeding_id
        duration = result["duration"][0..1].to_i*3600000+result["duration"][3..4].to_i*60000+result["duration"][6..7].to_i*1000
        feedings << {
          "id" => result["id"].to_i,
          "start_time" => result["start_time"],
          "end_time" => result["end_time"],
          "duration" => duration,
          "side" => result["side"],
          "foods" => []
        }
      end
      if result["food"]
        feedings.last["foods"] << result["food"]
      end
      last_feeding_id = result["id"]
    end

    return feedings

  end

  def self.find(id)
    results = DB.exec(
      <<-SQL
        SELECT
          feedings.*,
          feedings.end_time-feedings.start_time AS duration,
          foods.food
        FROM feedings LEFT JOIN foods
          ON time>(start_time-interval '6 hours')
          AND time<(start_time-interval '1 hour')
        WHERE feedings.id=#{id}
        ORDER BY start_time DESC;
      SQL
    )

    foods = []
    results.each do |result|
      if result["food"]
        foods << result["food"]
      end
    end

    result = results.first;
    duration = result["duration"][0..1].to_i*3600000+result["duration"][3..4].to_i*60000+result["duration"][6..7].to_i*1000
    return {
      "id" => result["id"].to_i,
      "start_time" => result["start_time"],
      "end_time" => result["end_time"],
      "duration" => duration,
      "side" => result["side"],
      "foods" => foods
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
