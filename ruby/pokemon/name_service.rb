module NameService
  def change_name(new_name)
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def get_name
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

end

