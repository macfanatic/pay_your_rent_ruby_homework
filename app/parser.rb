class Parser
  def self.read(path)
    [].tap do |leases|
      IO.foreach(path) do |line|

        # guard for blank lines
        next if line.gsub(/\s+/, '') == ''

        leases << Lease.parse(line.strip)
      end
    end
  end
end
