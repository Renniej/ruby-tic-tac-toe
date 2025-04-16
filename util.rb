class Object
  def is_number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end
