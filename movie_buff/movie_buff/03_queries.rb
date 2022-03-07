def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:id,:title)
    .joins(:actors)
    .where('actors.name IN (?)', those_actors)
    .group(:id)
    .having('COUNT(*) = ?',those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  year = Movie
    .select('yr/10*10 AS decade')
    .group('yr/10*10')
    .order('SUM(score) ASC')
    .limit(1)
  year.first.decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movies = Movie.select(:id).joins(:actors).where(actors: {name: name})
  Actor
    .joins(:movies)
    .where('movies.id IN (?)',movies)
    .group(:name)
    .having("name != ?",name)
    .pluck(:name)
    #.where("actors.name != ?", name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  hasbeens = Actor
    .select(:id)
    .left_outer_joins(:castings)
    .where('castings.id IS NULL')
  hasbeens.length
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  match = "%#{whazzername.split(//).join("%")}%"
  Movie
    .select(:id,:title,:yr,:score,:votes,:director_id)
    .joins(:actors)
    .where('UPPER(actors.name) LIKE UPPER(?)',match)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
    .select(:id,:name,'MAX(yr) - MIN(yr) AS career')
    .joins(:movies)
    .group(:id)
    .order('MAX(yr) - MIN(yr) DESC')
    .limit(3)
end
