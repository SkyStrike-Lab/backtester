#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

config="${1:-${ROOT_DIR}/config/config-google.json}"
output="${2:-${ROOT_DIR}/tmp/google.html}"

mkdir -p "$(dirname "${output}")"

# Recompute performance and generate the dashboard
PYTHONPATH="${ROOT_DIR}/src" python3 "${ROOT_DIR}/src/chart_performance.py" "${config}" "${output}"
