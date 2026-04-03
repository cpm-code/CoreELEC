# CE22 Amlogic-ng Sync Plan

Branch: `wip/ce22-ng-sync-20260402`

Reference upstream:
- Remote: `ce`
- Branch: `coreelec-22`
- Verified tip on 2026-04-02: `0bfaef01c106aa4e1673d3856af2b35907878635`

Goal:
- Move `master` closer to CoreELEC 22 userspace and packaging where safe.
- Upgrade the `Amlogic-ng` path as far as possible while remaining compatible with the 4.9 kernel and its driver stack.
- Keep `Ugoos_AM6B` on `S922X` as the primary acceptance target for every migration step.
- Preserve all package sources that already point to `cpm-code` on `master`.
- Maintain a buildable branch at each checkpoint.
- Be cautious: favor incremental uplift over aggressive rebases or large merges.

Acceptance target:
- Primary device path: `DEVICE=Amlogic-ng SUBDEVICE=Ugoos_AM6B`
- Primary SoC focus: `S922X`
- Required outcome for each major batch:
  - branch still builds with `make release`
  - no regression in the `Amlogic-ng` boot, userspace, or packaging path required by AM6B
- Secondary goal:
  - import additional CE22 changes from non-Amlogic areas when they reduce long-term divergence and do not increase 4.9 or AM6B risk

Why this branch is based on `master`, not upstream CE22:
- `master` already contains the active `Amlogic-ng` 4.9 device path.
- Latest upstream CE22 has moved kernel and driver plumbing far beyond the 4.9 stack.
- A direct CE22 base would force immediate reconciliation of kernel, firmware, driver, and init integration before a clean baseline build exists.
- `newb` is not a suitable base because it is still far behind the latest CE22 tip and already contains workaround commits tied to an older sync attempt.

Hard rules:
- Do not replace `master` package URLs that point to `cpm-code`.
- Keep these `master` sources authoritative unless there is an explicit reason to update them in their own repos:
  - `projects/Amlogic-ce/packages/linux/package.mk`
  - `projects/Amlogic-ce/packages/linux-drivers/amlogic/media_modules-aml/package.mk`
  - `projects/Amlogic-ce/packages/mediacenter/kodi/package.mk`
- Do not adopt upstream CE22 kernel, common driver, firmware, or userspace assumptions that require the newer Amlogic kernel line.
- Treat `Amlogic-no` as a reference source, not as a drop-in replacement for `Amlogic-ng`.
- Prefer upgrading `Amlogic-ng` userspace and project overrides wherever they can be kept 4.9-safe.

Known 4.9 compatibility boundaries:
- Kernel package:
  - `master` uses `amlogic-4.9` from `cpm-code/linux-amlogic`.
  - Upstream CE22 uses a much newer kernel package and different kernel-side assumptions.
- Media and GPU drivers:
  - `master` uses `cpm-code/media_modules-aml` and the existing `gpu-aml` flow.
  - Upstream CE22 driver packages are heavily reshaped for the newer kernel line.
- Device options:
  - `projects/Amlogic-ce/devices/Amlogic-ng/options` must remain the source of truth for the 4.9 device family.
  - `Amlogic-no` is useful only for feature comparison, packaging ideas, and userspace deltas.
- systemd:
  - `master` already carries `systemd 256.6`.
  - `newb` needed compatibility patches even for `258.5`.
  - Upstream CE22 is now on `260.1`.
  - Therefore systemd should stay pinned to the current working `master` state until later.
- Kodi:
  - Kodi can be upgraded in stages, but the project override in `projects/Amlogic-ce/packages/mediacenter/kodi/package.mk` must continue to use the `cpm-code/xbmc` source.
  - Any upstream CE22 Kodi packaging change must be reviewed against `libamcodec`, GBM, and Amlogic-specific integration.

Migration strategy:
1. Baseline
- Keep the branch identical to `master` except for planning metadata.
- Run a clean baseline build on this branch with:
  - `DEVICE=Amlogic-ng SUBDEVICE=Ugoos_AM6B make release`
- This confirms the branch is a known-good starting point.
- Status on 2026-04-02: baseline `make release` completed successfully on this branch.

2. Inventory and bucket upstream CE22 changes
- Split CE22 deltas into three buckets:
  - Safe candidates: generic package version bumps, addon changes, tooling updates, docs, non-platform packaging cleanup, and non-Amlogic project updates that do not affect the AM6B critical path.
  - Review required: `Amlogic-ng` project overrides, AM6B bootloader files, `Amlogic-ng` filesystem scripts and systemd units, Kodi, ffmpeg, mesa, bluez, connman, samba, util-linux, glib, cmake, Python-related build tooling.
  - Hold back: kernel, `common_drivers`, `media_modules-aml`, GPU stack changes tied to newer kernels, boot firmware, TEE, and device-specific service behavior that assumes newer kernel interfaces.

3. First uplift pass
- Prefer cherry-picking or manually porting small CE22 package updates onto this branch instead of merging CE22 wholesale.
- Keep each package family grouped into a reviewable commit.
- Build after each small batch.
- Where upstream CE22 has useful `Amlogic-no` userspace-side changes, port them into the `Amlogic-ng` path selectively rather than skipping them by default.
- Prioritize these `Amlogic-ng` areas first when they are packaging-only or userspace-only:
  - `projects/Amlogic-ce/devices/Amlogic-ng/options`
  - `projects/Amlogic-ce/devices/Amlogic-ng/kodi/`
  - `projects/Amlogic-ce/devices/Amlogic-ng/filesystem/`
  - `projects/Amlogic-ce/filesystem/usr/lib/systemd/system/`
- Treat AM6B-specific bootloader, DTB selection, initramfs, and install-to-eMMC logic as high sensitivity even when the diffs look small.

4. High-risk uplift pass
- Revisit `systemd`, Kodi, ffmpeg, mesa, and networking stack upgrades only after the low-risk package set compiles.
- Reuse ideas from `newb`, but do not inherit `newb` wholesale.
- Any compat patch required for 4.9 should be documented in the commit message and kept narrowly scoped.

5. Platform reconciliation
- If a CE22 feature depends on `Amlogic-no` behavior, port only the minimum userspace-facing parts that do not require replacing the 4.9 kernel path.
- Do not move `Amlogic-ng` onto CE22 kernel package structure unless that becomes an explicit kernel migration project.

Operational workflow:
- Use upstream CE22 as the reference branch:
  - `refs/remotes/ce/coreelec-22`
- Compare against `master` first, not `newb`.
- Use `newb` only as a source of known breakpoints and prior compat patches.
- Keep the branch buildable after every batch.
- If a package update forces kernel-side changes, stop and classify it as a hold-back item.

Suggested first package candidates:
- Generic host/build tooling that is not coupled to the kernel.
- Addon version bumps that do not affect the base image boot or login flow.
- Selected userland libraries already updated in `newb`, but only after confirming they do not require the newer CE22 platform stack.
- `Amlogic-ng` project-side userspace changes that do not require replacing the 4.9 kernel, media drivers, GPU drivers, or firmware source chain.
- Non-Amlogic CE22 package churn that helps reduce future merge delta, provided it stays outside the AM6B critical path.

Packages to defer initially:
- `packages/sysutils/systemd`
- `projects/Amlogic-ce/packages/linux/package.mk`
- `projects/Amlogic-ce/packages/linux-drivers/`
- Anything that replaces `cpm-code` package origins with upstream CoreELEC URLs.

`Amlogic-ng` scope guidance:
- `projects/Amlogic-ce/devices/Amlogic-ng/` is not frozen.
- Upgrade it cautiously where the changes are userspace-facing or packaging-only.
- Avoid changes that implicitly require newer kernel interfaces, driver ioctls, firmware layout, or boot chain behavior.
- Within `Amlogic-ng`, treat `Ugoos_AM6B` and shared `g12x` / `S922X` behavior as the priority path for validation.
- Other boards can benefit from shared `Amlogic-ng` uplift, but they are not allowed to drive risky changes into the AM6B path.

Secondary divergence reduction guidance:
- It is acceptable to bring in unrelated CE22 changes, including other project or addon updates such as Rockchip-side work, when all of the following are true:
  - the change is isolated from `Amlogic-ng` boot, kernel, driver, and AM6B packaging behavior
  - it does not replace any `cpm-code` package origin used by `master`
  - it keeps the branch easier to compare against the latest CE22
  - it does not block or confuse AM6B-focused validation

Current conclusion:
- The safe path is not "take CE22 and apply `master` on top" as the working branch.
- The safe path is "start from `master`, use the latest CE22 as a reference source, and selectively import what survives the 4.9 boundary."
- If needed, a separate scratch branch can still be created from CE22 for conflict study, but it should not be the main integration branch.

Progress log:
- 2026-04-02: created `wip/ce22-ng-sync-20260402` from `master`.
- 2026-04-02: verified latest upstream CE22 reference at `0bfaef01c106aa4e1673d3856af2b35907878635`.
- 2026-04-02: baseline `DEVICE=Amlogic-ng SUBDEVICE=Ugoos_AM6B make release` completed successfully.
- 2026-04-02: imported first low-risk CE22 sync batch in addon dependency packages:
  - `ccid`
  - `faad2`
  - `hidapi`
  - `libconfig`
  - `libexif`
  - `libgpiod`
  - `libmpdclient`
  - `libvpx`
  - `libzip`
- 2026-04-02: AM6B release build completed successfully after the first batch.
- 2026-04-02: imported second cautious sync batch:
  - `libhdhomerun`
  - `libid3tag`
  - `libimobiledevice-glue`
  - `libusbmuxd`
  - `pycryptodome`
- 2026-04-02: AM6B release build completed successfully after the second batch.
- 2026-04-02: upgraded `packages/multimedia/ffmpeg/package.mk` from `8.0.1` to `8.1`.
- 2026-04-02: replaced the local FFmpeg patch stack with the CE22 versions for:
  - `patches/0001-added_upstream_mvc_patches.patch`
  - `patches/libreelec/ffmpeg-001-libreelec.patch`
  - `patches/postproc/ffmpeg-001-postproc.patch`
- 2026-04-02: preserved the local-only patch `patches/libreelec/ffmpeg-003-pgs-bt2020-colorspace.patch`.
- 2026-04-02: removed the obsolete local arm FFmpeg patch not present in CE22.
 - 2026-04-02: AM6B release build completed successfully with FFmpeg `8.1` and the CE22 patch stack plus the local PGS patch.
 - 2026-04-02: imported a non-Kodi tooling/network batch:
   - `cmake`
   - `libnftnl`
   - `bluez`
 - 2026-04-02: AM6B release build completed successfully after the tooling/network batch.
 - 2026-04-02: attempted a CE22 `nspr`/`nss` uplift, but reverted it after host-side NSS utility link failures to keep the branch green.
 - 2026-04-02: imported a low-risk compression batch:
   - `zlib`
   - `zstd`
   - `libarchive`
   - `xz`
 - 2026-04-02: AM6B release build completed successfully after the compression batch.
 - 2026-04-02: imported additional low-hanging addon dependency updates:
   - `oniguruma`
   - `jq`
   - `libsodium`
   - `liblogging`
   - `liblognorm`
   - `librelp`
   - `libssh2`
 - 2026-04-02: AM6B release build completed successfully after the addon dependency batches.
 - 2026-04-02: updated `libvncserver` to the CE22 package version and removed the now-obsolete local OpenSSL 3 patch.
 - 2026-04-02: imported additional low-hanging addon tool updates:
   - `tree`
   - `stress-ng`
   - `inotify-tools`
   - `pv`
   - `smartmontools`
 - 2026-04-02: AM6B release build completed successfully after the `libvncserver` and addon tool batches.
 - 2026-04-02: imported the conservative follow-up batch:
   - `autossh`
   - `mmc-utils`
   - `dtach`
   - `libpcap`
 - 2026-04-02: AM6B release build completed successfully after the conservative follow-up batch.
 - 2026-04-02: synced `pcsc-lite` with its addon consumer `service.pcscd`.
 - 2026-04-02: AM6B release build completed successfully after the `pcsc-lite` and `service.pcscd` batch.
 - 2026-04-02: synced `libplist` and `shairport-sync` as a broader userspace/addon batch.
 - 2026-04-02: AM6B release build completed successfully after the `libplist` and `shairport-sync` batch.
 - 2026-04-02: updated addon-side `icu` to the CE22 package version and source layout.
 - 2026-04-02: AM6B release build completed successfully after the `icu` batch.
 - 2026-04-02: updated addon-side `libmtp` to the CE22 package version, dependency set, and simplified patch stack.
 - 2026-04-02: AM6B release build completed successfully after the `libmtp` batch.
 - 2026-04-02: updated `glib` to the CE22 package version and meson configuration.
 - 2026-04-02: AM6B release build completed successfully after the `glib` batch.
 - 2026-04-02: updated `connman` to the CE22 package version and dependency set, and dropped two obsolete local patches.
 - 2026-04-02: AM6B release build completed successfully after the `connman` batch.
 - 2026-04-02: updated `samba` to the CE22 package version, dependency set, server targets, and VFS install layout.
 - 2026-04-02: AM6B release build completed successfully after the `samba` batch.
 - 2026-04-02: applied a narrow Kodi packaging batch in the Amlogic-ce project override:
   - added the CE22 `wayland` dependency for the `libamcodec` player path
   - switched Kodi packaging to external FFmpeg
   - disabled FFmpeg source plugins
   - disabled internal `nlohmann-json` and internal MariaDB client
   - dropped the explicit Python include path override
 - 2026-04-02: AM6B release build completed successfully after the narrow Kodi packaging batch.
 - 2026-04-02: updated `openssh` to 10.2p1 and retargeted its three local patches to the actual 10.2p1 source layout used on this branch.
 - 2026-04-02: updated six additional non-Kodi networking/runtime packages:
   - `ethtool` -> 6.19
   - `iw` -> 6.17
   - `iwd` -> 3.12
   - `libssh` -> 0.12.0
   - `libtirpc` -> 1.3.7
   - `netbase` -> 6.5
 - 2026-04-02: attempted `libnl` 3.12.0, but held it back after it required newer ILA kernel header definitions than available on the current 4.9-based branch.
 - 2026-04-02: AM6B release build completed successfully after the `openssh` + six-package networking batch.
 - 2026-04-02: updated a second six-package non-Kodi batch:
   - `libdnet` -> 1.18.2
   - `wireless-regdb` -> 2026.02.04
   - `cifs-utils` -> 7.5
   - `openvpn` -> 2.7.0
   - `exfatprogs` -> 1.3.2
   - `libusb` -> 1.0.29
 - 2026-04-02: AM6B release build completed successfully after the second six-package batch.
 - 2026-04-02: updated a third six-package non-Kodi batch:
   - `dbus` -> 1.16.2
   - `e2fsprogs` -> 1.47.4
   - `fuse3` -> 3.18.2
   - `pciutils` -> 3.14.0
   - `gnutls` -> 3.8.12
   - `libgpg-error` -> 1.59
 - 2026-04-02: AM6B release build completed successfully after the third six-package batch.
 - 2026-04-02: updated a larger devel/toolchain batch:
   - `autoconf-archive` -> 2024.10.16
   - `autoconf` -> current CE22 package flags
   - `automake` -> 1.18.1
   - `bison` -> current CE22 package flags/url
   - `boost` -> 1.90.0
   - `ccache` -> 4.13.2
   - `commons-lang3` -> 3.20.0
   - `commons-text` -> 1.15.0
   - `fakeroot` -> 1.37.2
   - `flatbuffers` -> 25.12.19
   - `groovy` -> 4.0.30
   - `hwdata` -> 0.405
   - `intltool` -> current CE22 package flags
   - `json-c` -> 0.18
   - `json-glib` -> 1.10.8
   - `libcap-ng` -> 0.9.2
   - `libcap` -> 2.77
   - `libdisplay-info` -> 0.3.0
   - `libffi` -> 3.5.2
   - `libfmt` -> 12.1.0
   - companion: `spdlog` -> 1.17.0 to match `libfmt` 12 API expectations
 - 2026-04-02: initial validation of the large devel batch exposed a `libfmt`/`spdlog` API mismatch in Kodi; updating `spdlog` to the CE22 version resolved it.
 - 2026-04-02: AM6B release build completed successfully after the large devel/toolchain batch.
 - 2026-04-02: updated a Python tooling batch:
   - `Jinja2` -> 3.1.6
   - `Mako` -> 1.3.10
   - `MarkupSafe` -> 3.0.3
   - `flit` -> 3.12.0
   - `hatchling` -> 1.16.5
   - `lxml` -> 6.0.2 (new package)
   - `meson` -> 1.10.2
   - `ninja` -> 1.13.2
   - `pybind11` -> 3.0.2
   - `pybuild` -> 1.4.2
   - `pycparser` -> 3.0
   - `pyelftools` -> 0.32
   - `pypackaging` -> 26.0
   - `pyproject-hooks` -> 1.2.0
   - `python-pathspec` -> 1.0.4
   - `pyyaml` -> 6.0.3
   - `scikit-build-core` -> 0.12.2
   - `setuptools` -> 82.0.1
   - `waf` -> 2.1.9
   - `Pillow` -> 12.1.1
 - 2026-04-02: AM6B release build completed successfully after the Python tooling batch.
 - 2026-04-02: updated a fifty-package graphics/display/addons batch:
   - Vulkan: `glslang` -> 16.2.0, `vkmark` -> 2025.01, `volk` -> 1.4.304, `vulkan-headers` -> 1.4.347, `vulkan-loader` -> 1.4.347
   - Wayland: `fcft` -> 3.3.3, `seatd` -> 0.9.3, `wlroots` -> 0.19.3, `foot` -> 1.26.1, `swaybg` -> 1.2.2, `wlr-randr` -> 0.5.0
   - X11 apps/data/drivers: `setxkbmap` -> 1.3.5, `xkbcomp` -> 1.5.0, `xrandr` -> 1.5.3, `xkeyboard-config` -> 2.47, `xf86-input-evdev` -> 2.11.0, `xf86-input-libinput` -> 1.5.0, `xf86-input-synaptics` -> 1.10.0, `xf86-video-intel` -> 4a64400ec6a7d8c0aba0e6a39b16a5e86d0af843
   - X11 libs/proto/util: `libICE` -> 1.1.2, `libSM` -> 1.2.6, `libXau` -> 1.0.12, `libXcomposite` -> 0.4.7, `libXdamage` -> 1.1.7, `libXext` -> 1.3.7, `libXfixes` -> 6.0.2, `libXinerama` -> 1.1.6, `libXrandr` -> 1.5.5, `libXrender` -> 0.9.12, `libXt` -> 1.3.1, `libXxf86vm` -> 1.1.7, `libfontenc` -> 1.1.9, `libpciaccess` -> 0.19, `libxcvt` -> 0.1.3, `libxkbfile` -> 1.2.0, `libxshmfence` -> 1.3.3, `xtrans` -> 1.6.0, `fontconfig` -> 2.17.1, `xcb-proto` -> current CE22 flags, `xorgproto` -> 2025.1, `util-macros` -> 1.20.2
   - Addons/tools/services: `btrfs-progs` addon -> 6.19.1 rev 1, `dotnet-runtime` addon rev 2, `dvb-tools` addon updated to `w_scan2`, `flirc_util` -> 280cccbb333f5be30fc48ea958ca103d2fce6fec, `system-tools` addon expanded for `btop` and `tmux`, `ttyd` addon rev 1, `usbmuxd` -> 523f7004dce885fe38b4f80e34a8f76dc8ea98b5, `podman` addon packaging refresh, `steamlink` script updated to 1.3.22.298
 - 2026-04-02: `xkeyboard-config` 2.47 required a local compatibility fix to replace the new `/usr/share/X11/xkb` symlink layout with a real directory in `${SYSROOT_PREFIX}` and `${INSTALL}`, because the CoreELEC sysroot copy step cannot overwrite an existing directory with a symlink.
 - 2026-04-02: AM6B release build completed successfully after the fifty-package graphics/display/addons batch.
 - 2026-04-02: updated a fifty-package Kodi binary addon batch:
   - Audio decoders: `audiodecoder.2sf`, `asap`, `dumb`, `fluidsynth`, `gme`, `gsf`, `modplug`, `nosefart`, `openmpt`, `organya`, `qsf`, `sacd`, `sidplay`, `snesapu`, `ssf`, `stsound`, `timidity`, `upse`, `usf`, `vgmstream`, `wsr`
   - Audio encoders: `audioencoder.flac`, `lame`, `vorbis`, `wav`
   - Image/peripheral: `imagedecoder.heif`, `mpo`, `raw`, `peripheral.xarcade`
   - PVR addons: `pvr.argustv`, `demo`, `dvblink`, `dvbviewer`, `filmon`, `freebox`, `hdhomerun`, `mediaportal.tvserver`, `mythtv`, `njoy`, `octonet`, `pctv`, `plutotv`, `sledovanitv.cz`, `stalker`, `teleboy`, `vbox`, `vuplus`, `waipu`, `wmc`, `zattoo`
 - 2026-04-02: AM6B release build completed successfully after the fifty-package Kodi binary addon batch.
 - 2026-04-03: synced the entire remaining `master..ce/coreelec-22` CoreELEC repo delta, not just packages. Exact comparison against `refs/remotes/ce/coreelec-22` is now clean except for two intentional local compatibility patches:
   - `packages/x11/data/xkeyboard-config/package.mk`: preserve a real `/usr/share/X11/xkb` directory in `${SYSROOT_PREFIX}` and `${INSTALL}` because CoreELEC's sysroot copy logic fails on the CE22 symlinked layout.
   - `projects/Amlogic-ce/devices/Amlogic-no/options`: keep `KERNEL_COMPILER="gcc"` locally and make `SUBDEVICES` environment-overridable so validation can proceed on this host.
 - 2026-04-03: removed stale generated output `build.CoreELEC-Amlogic-ng.aarch64-22` to recover disk space after the first CE22-native validation ran out of storage.
 - 2026-04-03: the old acceptance target `DEVICE=Amlogic-ng SUBDEVICE=Ugoos_AM6B` is no longer valid in the fully synced CE22 tree; CE22 now defaults to `PROJECT=Amlogic-ce DEVICE=Amlogic-no ARCH=aarch64`.
 - 2026-04-03: full CE22-native validation remains blocked by host environment limits, not by remaining sync drift:
   - default `Amlogic-no` build tries to build `u-boot-Odroid_C5`, which invokes an x86_64 userspace binary and fails on this host with missing `/lib64/ld-linux-x86-64.so.2`.
   - even with `SUBDEVICES=Odroid_N2`, the build later reaches `bl30` and fails for the same x86_64 userspace reason.
 - 2026-04-03: conclusion after the repo-wide sync: CE22 content import is complete; remaining validation failures are host-specific vendor-tool execution issues in Amlogic bootloader/blob build steps.
- 2026-04-03: scope was explicitly narrowed back to `Amlogic-ng` / `Ugoos_AM6B` only.
- 2026-04-03: restored the `master`-authoritative `Amlogic-ng` project and build layers on top of the generic CE22 package sync:
  - restored `projects/Amlogic-ce` to the `master` Amlogic-ng-oriented state and removed CE22-only additions under that tree
  - restored `distributions/CoreELEC/splash/Amlogic-ng`
  - restored `Makefile`, `config/`, `scripts/`, `distributions/CoreELEC/options`, `packages/linux-drivers`, and `packages/virtual/linux-drivers` to the `master` state needed by the Amlogic-ng build graph
- 2026-04-03: `DEVICE=Amlogic-ng SUBDEVICE=Ugoos_AM6B make release` now runs again on the intended target and gets past project/config resolution.
- 2026-04-03: current AM6B blockers are no longer Amlogic-no host-tool issues; they are stale patch leftovers in generic CE22-updated packages layered on top of the restored Amlogic-ng branch. Cleaned so far:
  - `gettext`
  - `giflib`
  - `elfutils`
  - `rsync`
- 2026-04-03: latest AM6B blocker at this checkpoint is `Python3:host`, where the CE22 package update is still carrying stale master-only patch files (`0004`, `0012`, and `py312-*`) that no longer apply cleanly.