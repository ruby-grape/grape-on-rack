class OStats
  def initialize options
    @filters = (options.delete :filters) || ['']
    @suppress_nodelta = options.delete :suppress_nodelta
    @stats = Array.new
  end

  def collect!
    stats = Hash.new(0)

    ObjectSpace.each_object do |o|
      @filters.each do |f|
        stats[o.class] += 1 if o.class.name.start_with? f
      end
    end

    @stats << stats
  end

  def display
    @stats[-1].sort {|(k1,v1),(k2,v2)| v2 <=> v1}.each do |k,v|
      delta = ((v - @stats[-2][k]) unless @stats[-2].nil?) || 0
      if !@suppress_nodelta or delta != 0
        printf "%-50s %6d", k, v
        if !@suppress_nodelta or delta != 0
          printf " delta %6d", delta
        end
        puts
      end
    end
  end
end
