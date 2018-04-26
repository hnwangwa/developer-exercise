
class Array
  def where(hash = {})
    matches = []
    
    self.each do |ele|
      # only adds the match if all predicates (key / value pairs) of the hash match.
      matches << ele if hash.all? { |k, v| match(ele[k], v) }
    end
    return matches
  end

  # handles the matching (generalizing this made things simpler)
  private def match(a, b)
    if b.class == Regexp
      return a =~ b
    else
      return a == b
    end
  end
end