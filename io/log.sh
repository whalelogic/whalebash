#!/bin/bash

# log.sh — Structured log output with levels and optional timestamps.
# Source this file to use log functions in other scripts.
#
# Usage (sourced):  source io/log.sh
#                   log_info "Server started"
#                   log_warn "Disk nearing capacity"
#                   log_error "Connection failed"
#
# Usage (direct):   ./log.sh info "Server started"

# Log level threshold: DEBUG=0 INFO=1 WARN=2 ERROR=3
declare -A _LOG_LEVELS=([DEBUG]=0 [INFO]=1 [WARN]=2 [ERROR]=3)
_LOG_THRESHOLD="${WHALEBASH_LOG_LEVEL:-INFO}"
_LOG_TIMESTAMPS="${WHALEBASH_LOG_TIMESTAMPS:-true}"

_log() {
    local level="$1"; shift
    local threshold="${_LOG_LEVELS[$_LOG_THRESHOLD]:-1}"
    local current="${_LOG_LEVELS[$level]:-1}"

    [[ "$current" -lt "$threshold" ]] && return 0

    local ts=""
    [[ "$_LOG_TIMESTAMPS" == "true" ]] && ts="[$(date '+%Y-%m-%d %H:%M:%S')] "

    local msg="${ts}[${level}] $*"

    if [[ "$level" == "ERROR" || "$level" == "WARN" ]]; then
        echo "$msg" >&2
    else
        echo "$msg"
    fi
}

log_debug() { _log "DEBUG" "$@"; }
log_info()  { _log "INFO"  "$@"; }
log_warn()  { _log "WARN"  "$@"; }
log_error() { _log "ERROR" "$@"; }

# Allow direct invocation: ./log.sh <level> <message>
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    if [[ $# -lt 2 ]]; then
        echo "Usage: $0 <debug|info|warn|error> <message>" >&2
        exit 1
    fi
    level="${1^^}"; shift
    _log "$level" "$@"
fi
