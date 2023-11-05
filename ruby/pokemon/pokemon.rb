class Pokemon
  include NameService

  private attr_accessor :name

  def initialize(type1, type2, hp)
    @name = ''
    @type1 = type1
    @type2 = type2
    @hp = hp
  end

  def get_name
    self.name
  end

  def change_name(new_name)
    return '不適切' if new_name == 'XXX'
    @name=(new_name)
  end

  def attack
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

end