# Alternative ZSH Benchmarking Approaches

Based on research, here are several better approaches for benchmarking your zsh startup:

## 1. ZSH Built-in Profiler (Recommended)

Add this to the top of your `.zshrc`:
```bash
# Enable profiling conditionally
if [[ -n "${ZSH_PROFILE_STARTUP:+x}" ]]; then
    zmodload zsh/zprof
fi
```

Add this to the bottom:
```bash
if [[ -n "${ZSH_PROFILE_STARTUP:+x}" ]]; then
    zprof
fi
```

Usage:
```bash
ZSH_PROFILE_STARTUP=1 zsh -i -c exit
```

## 2. Hyperfine (Industry Standard)

Install with: `brew install hyperfine`

Usage:
```bash
# Basic shell startup benchmarking
hyperfine 'zsh -i -c exit'

# Compare different configurations
hyperfine 'zsh -i -c exit' 'bash -i -c exit'

# With cache clearing (for more consistent results)
hyperfine --prepare 'sync' 'zsh -i -c exit'
```

## 3. Simple SECONDS Variable Approach

```bash
# At top of .zshrc
if [[ -n "${ZSH_PROFILE_STARTUP:+x}" ]]; then
    SECONDS=0
fi

# Function for section timing
time_section() {
    if [[ -n "${ZSH_PROFILE_STARTUP:+x}" ]]; then
        echo "[$1] ${SECONDS}s" >&2
    fi
}

# Usage throughout .zshrc
time_section "oh-my-zsh loaded"
# ... more code ...
time_section "plugins loaded"
```

## 4. Advanced EPOCHREALTIME Wrapper

```bash
# Enhanced timing function
benchmark_section() {
    if [[ -n "${ZSH_PROFILE_STARTUP:+x}" && -n "${EPOCHREALTIME+x}" ]]; then
        local start_time=$EPOCHREALTIME
        eval "$2"  # Execute the code
        local end_time=$EPOCHREALTIME
        local elapsed_ms=$(( (${end_time/./} - ${start_time/./}) / 1000 ))
        echo "[$1] ${elapsed_ms}ms" >&2
    else
        eval "$2"  # Just execute without timing
    fi
}

# Usage:
benchmark_section "Loading oh-my-zsh" 'source "${ZSH}/oh-my-zsh.sh"'
```

## 5. Trace-Based Timing (Advanced)

```bash
# Add to top of .zshrc for detailed tracing
if [[ -n "${ZSH_TRACE_STARTUP:+x}" ]]; then
    PS4='+ $EPOCHREALTIME %N:%i> '
    exec 3>&2 2>/tmp/zsh-startup-trace.log
    setopt xtrace prompt_subst
fi

# Add to bottom
if [[ -n "${ZSH_TRACE_STARTUP:+x}" ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
    echo "Trace saved to /tmp/zsh-startup-trace.log"
fi
```

Usage: `ZSH_TRACE_STARTUP=1 zsh -i -c exit`

## Key Improvements Over Your Current Approach

1. **No subprocess overhead** - EPOCHREALTIME is a shell variable
2. **Monotonic timing** - Won't have negative values from clock adjustments  
3. **Microsecond precision** - Much more accurate than date +%N
4. **Conditional execution** - Only runs when needed
5. **Standard tools** - Uses established benchmarking practices

## Recommendation

Start with the **zprof** approach for detailed analysis, then use **hyperfine** for consistent measurements across different configurations. Your improved EPOCHREALTIME approach should eliminate the negative timing issues you were seeing.