function _sshl
    ssh 192.168.1.$argv[1] $argv[2..-1]
end

# Create alias for easier listing
alias :sshl='_sshl'
