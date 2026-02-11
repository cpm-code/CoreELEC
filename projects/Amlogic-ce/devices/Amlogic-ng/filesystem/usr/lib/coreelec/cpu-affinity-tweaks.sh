#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# CoreELEC S922X CPU affinity helpers

set -eu

# Only apply on 6-core S922X-style systems (cpu5 exists).
[ -d /sys/devices/system/cpu/cpu5 ] || exit 0

# Keep unbound workqueues off CPU5 (6 CPUs => mask 0x1f = CPUs 0-4).
if [ -w /sys/devices/virtual/workqueue/cpumask ]; then
  echo 1f > /sys/devices/virtual/workqueue/cpumask 2>/dev/null || true
fi

# Keep background services off the Kodi render core (CPU5) and VideoPlayer core (CPU3).
ALLOWED_CPUS="0 1 2 4"
UNITS="nfs-mountd.service nfsdcld.service smbd.service avahi-daemon.service wpa_supplicant.service sshd.service"

for unit in $UNITS; do
  # Only apply to units that exist on this image.
  systemctl cat "$unit" >/dev/null 2>&1 || continue

  dropin_dir="/run/systemd/system/${unit}.d"
  mkdir -p "$dropin_dir"
  cat > "$dropin_dir/10-cpu-affinity.conf" <<EOF
[Service]
CPUAffinity=$ALLOWED_CPUS
EOF
done

# Reload systemd so the runtime drop-ins are recognized.
systemctl daemon-reload >/dev/null 2>&1 || true

# Apply to already-running services (no-op if inactive).
for unit in $UNITS; do
  systemctl cat "$unit" >/dev/null 2>&1 || continue
  systemctl try-restart "$unit" >/dev/null 2>&1 || true
done

exit 0
