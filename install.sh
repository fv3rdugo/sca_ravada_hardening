#!/bin/bash
# RavadaVDI hardening server — Installer
# https://github.com/fv3rdugo/sca_ravada_hardening

set -euo pipefail

WAZUH_DIR="/var/ossec"
SCA_DIR="${WAZUH_DIR}/ruleset/sca"
RULES_DIR="${WAZUH_DIR}/etc/rules"
OSSEC_CONF="${WAZUH_DIR}/etc/ossec.conf"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

echo ""
echo "  RavadaVDI hardening Wazuh Integration — Installer"
echo "  https://github.com/fv3rdugo/sca_ravada_hardening"

echo ""

# --- Checks ---

[[ $EUID -ne 0 ]] && error "This script must be run as root."

#TO_DO