# CE22 Workflow Reference

## Canonical Sources
- Upstream branch: `ce/coreelec-22`
- Upstream browser reference: `https://github.com/CoreELEC/CoreELEC/tree/coreelec-22`
- Local decision log: `CE22-NG-SYNC-PLAN.md`
- Repo memory summary: `/memories/repo/coreelec-ce22-sync.md`

## Hard Boundaries
- Preserve all package sources that already point to `cpm-code`.
- Do not replace the local `Amlogic-ng` 4.9 kernel, linux-drivers, `media_modules-aml`, GPU stack, boot firmware flow, or systemd without explicit scope.
- Treat `projects/Amlogic-ce/packages/mediacenter/kodi/package.mk` as high sensitivity; only change it when Kodi packaging is explicitly requested.
- Keep unrelated local worktree changes intact.

## Candidate Selection
1. Start with exact upstream package metadata matches: version, hash, URL, release commit.
2. Next consider packaging-only or userspace-only changes that do not cross the 4.9 kernel boundary.
3. Hold back anything that implies kernel header updates, new driver interfaces, firmware layout changes, or newer Amlogic platform assumptions.

## Validation Ladder
1. Run the cheapest focused validation immediately after the first substantive edit.
2. For package-only `package.mk` batches, use `bash -n` on edited files and confirm intended files are clean against `git diff ce/coreelec-22`.
3. For logic or patch-stack changes, run the narrowest available package or build validation before expanding scope.
4. Only use diff-only validation when no executable check exists.

## Update Checklist
- Refresh the fetched upstream tip in `CE22-NG-SYNC-PLAN.md`.
- Append a dated progress log entry with touched packages and validation results.
- Record durable findings in repo memory.
- Call out anything intentionally skipped or left divergent.
