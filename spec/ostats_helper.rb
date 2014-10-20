class OStats
  def initialize options
    @filters = (options.delete :filters) || ['']
    @suppress_nodelta = options.delete :suppress_nodelta
    @stats = Array.new

    setup_allocation_tracing options
  end

  def collect!
    stats = Hash.new(0)

    ObjectSpace.each_object do |o|
      @filters.each do |f|
        if o.class.name.start_with? f
          count_allocation_of o
          stats[o.class] += 1
        end
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
        if @trace_allocations
          @allocations[k].each do |k, v|
            printf "%-63s %6d\n", k, v
          end
        end
      end
    end
  end

  private
  def count_allocation_of object
    if @trace_allocations
      @allocations[object.class] ||= Hash.new(0)
      loc = allocation_location_for object
      (@allocations[object.class][loc] += 1) unless loc.nil?
    end
  end

  def allocation_location_for object
    filename = ObjectSpace.allocation_sourcefile(object)
    unless filename.nil?
      filename = "  # lib#{filename.split('lib')[1]}"
      line = ObjectSpace.allocation_sourceline(object)
      "#{filename}:#{line}"
    end
  end

  def setup_allocation_tracing options
    @trace_allocations = false

    if options.delete :trace_allocations
      require 'objspace'
      ObjectSpace.trace_object_allocations_start
      @trace_allocations = true
      @allocations = Hash.new
    end
  end
end
