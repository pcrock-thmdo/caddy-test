#!/usr/bin/env nu

const fastly_ip_url = "https://api.fastly.com/public-ip-list"

def main [
    mode: string  # either "fastly" or "all"
] {
    match $mode {
        "fastly" => { allow_fastly },
        "all" => { allow_all },
        "private" => { allow_private_ranges },
        _ => { error make { msg: $"unrecognized mode: \"($mode)\". expected \"fastly\", \"all\", or \"private\"" } }
    }
    | save --force "ip-filter.Caddyfile"
}

def allow_fastly [] {
    $"@blocked_ips {
\tnot client_ip (get_fastly_subnets)
}
"
}

def allow_all [] {
    $"@blocked_ips {
\t# https://caddyserver.com/docs/caddyfile/matchers#expression
\t# return false so NO request is considered a blocked request
\texpression `false`
}
"
}

def allow_private_ranges [] {
    $"@blocked_ips {
\tnot client_ip private_ranges
}
"
}

# get space-delimited list of Fastly subnets in CIDR notation
def get_fastly_subnets [] {
    http get $fastly_ip_url | each {|it|
        $it.addresses | append $it.ipv6_addresses
    }
    | flatten
    | reduce {|it, acc|
        $"($acc) ($it)"
    }
}
