class Array
  def summm(start = 0)
    inject(start, &:+)
  end
end