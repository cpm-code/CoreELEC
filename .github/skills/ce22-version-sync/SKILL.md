---
name: ce22-version-sync
description: 'Upgrade CoreELEC against upstream coreelec-22 while preserving the local Amlogic-ng 4.9 path and cpm-code package origins. Use when asked to sync version bumps, compare against upstream CoreELEC/coreelec-22, refresh CE22-NG-SYNC-PLAN.md, or record CE22 sync memory.'
argument-hint: 'Describe the sync scope or package family to review'
user-invocable: true
---

# CE22 Version Sync

## When to Use
- Update CoreELEC package versions from upstream `ce/coreelec-22`
- Review remaining drift against upstream CE22
- Refresh `CE22-NG-SYNC-PLAN.md` after a sync batch
- Record durable CoreELEC sync guidance in repo memory
- Decide whether an upstream change is safe for the local `Amlogic-ng` 4.9 branch

## Procedure
1. Read the canonical plan at `CE22-NG-SYNC-PLAN.md` in the repo root.
2. Read `/memories/repo/coreelec-ce22-sync.md` and any relevant packaging notes.
3. Fetch `ce/coreelec-22`, then diff current `HEAD` against that ref.
4. Follow the [workflow reference](./references/workflow.md) to bucket changes into safe metadata, review-required userspace changes, and explicit hold-backs.
5. Preserve any unrelated local edits already present in the worktree.
6. Patch the smallest safe batch first, keeping `cpm-code` package origins and the `Amlogic-ng` 4.9 boundary intact.
7. Validate immediately after the first substantive edit.
8. Update `CE22-NG-SYNC-PLAN.md` with the fetched upstream tip, touched packages, validation result, and any intentional exclusions.
9. Update repo memory with durable rules, newly verified blockers, or completed sync batches.

## Expected Output
- Minimal, reviewable package sync edits
- An updated `CE22-NG-SYNC-PLAN.md`
- Updated repo memory for future sync passes
- A short note about anything intentionally left divergent from upstream
