require 'test/unit'

class WrongNumberOfPlayersError < StandardError ; end

class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2
  raise NoSuchStrategyError unless game.select {|v| !['P', 'S', 'R'].include?(v[1])}.empty?

  strategy1 = game[0][1]
  strategy2 = game[1][1]

  player1 = game[0]
  player2 = game[1]

  if (strategy1 == strategy2) ; return player1 ; end

  if (strategy1 == 'P')
    winner = strategy2 == 'R' ? player1 : player2
  elsif (strategy1 == 'R')
    winner = strategy2 == 'S' ? player1 : player2
  elsif (strategy1 == 'S')
    winner = strategy2 == 'P' ? player1 : player2
  end

  return winner
end

def rps_tournament_winner(tournament)
  if (tournament[0].class == String)
  return tournament
  end
  player1 = rps_tournament_winner(tournament[0])
  player2 = rps_tournament_winner(tournament[1])
  return rps_game_winner([player1, player2])
end

class TestRps < Test::Unit::TestCase
  def test_equal_strategies
    assert_equal(["Armando", "P"], rps_game_winner([ [ "Armando", "P" ], [ "Dave", "P" ] ]) )
  end

  def test_wrong_stragey
    assert_raise NoSuchStrategyError do  rps_game_winner [ [ "Armando", "P" ], [ "Dave", "G" ] ]  end
  end

  def test_wrong_number_of_players
    assert_raise WrongNumberOfPlayersError do  rps_game_winner [ [ "Armando", "P" ] ]  end
  end

  def test_rest
    assert_equal([ "Dave", "S" ], rps_game_winner([ [ "Armando", "P" ], [ "Dave", "S" ] ]))
    assert_equal([ "Armando", "R" ], rps_game_winner([ [ "Armando", "R" ], [ "Dave", "S" ] ]))
    assert_equal([ "Armando", "P" ], rps_game_winner([ [ "Armando", "P" ], [ "Dave", "R" ] ]))
  end

  def test_rps_tournament_winner
    tournament = [
      [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"],  ["Michael", "S"] ],
      ],
      [
        [ ["Allen", "S"], ["Omer", "P"] ],
        [ ["David E.", "R"], ["Richard X.", "P"] ]
      ]
    ]
    assert_equal(["Richard", "R"], rps_tournament_winner(tournament))
  end
end
