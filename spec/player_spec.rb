require 'player'

describe Player do

  subject(:player) { Player.new }

  describe "#initialize" do

    it "will allow for a name to be designated" do
      john = Player.new('John')
      expect(john.name).to eq('John')
    end

    it "will provide a default name if no name is specificed" do
      expect(player.name).to be_kind_of(String)
    end

    it "generates a default initial score of zero" do
      expect(player.score).to eq(0)
    end

    it "sets guessed letters to an empty array" do
      expect(player.guessed_letters).to be_empty
    end

    it "sets guessed_words to an empty array" do
      expect(player.guessed_words).to be_empty
    end

  end

  describe "#guess" do

    it "returns an appropriate letter from STDIN" do
      subject.stub(:gets) {'a'}
      guess = player.guess
      expect(guess).to eq('a')
    end

    it "raises an error if there STDIN doesn't provide a letter" do
      subject.stub(:gets) {'1'}
      expect { player.guess }.to raise_error(
        "That ain't no word and it ain't no letter neither!"
        )
    end

    it "returns an appropriate word from STDIN" do
      subject.stub(:gets) {'scuba'}
      expect(player.guess).to eq('scuba')
    end

    it "raises and error if STDIN does not provide an appropriate word" do
      subject.stub(:gets) {'1 luv sCu8a'}
      expect { player.guess }.to raise_error(
        "That ain't no word and it ain't no letter neither!"
        )
    end

    it "adds the players guessed letters to its guessed_letters" do
      subject.stub(:gets) {'a'}
      guess = player.guess
      expect(player.guessed_letters).to include(guess)
    end

    it "adds players guessed words to its guessed_words" do
      subject.stub(:gets) {'rspec'}
      guess = player.guess
      expect(player.guessed_words).to include(guess)
    end

    it "adds only unique guessed letters to guessed_letters" do
      p = player
      subject.stub(:gets) {'c'}
      10.times do
        p.guess
      end
      expect(p.guessed_letters).to match_array(['c'])
    end

    it "adds only unique guessed words to guessed_words" do
      p = player
      subject.stub(:gets) {'nah'}
      8.times do
        p.guess
      end
      subject.stub(:gets) {'Batman'}
      p.guess
      expect(p.guessed_words).to contain_exactly('nah', 'batman')
    end

  end

end
