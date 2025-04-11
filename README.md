# Drizzle Kit Pull Error with gel/Gel (`module default`)

This repository demonstrates two issues when running `drizzle-kit pull` against a simple Gel schema.

## Problems

1. [`drizzle-kit pull` fails with a `TypeError` when any Gel schema contains a custom-defined enum.](#issue-1)
2. [`drizzle-kit pull` succeeds, but creates 0 schema when types are defined within a non-default module (e.g., `module foo {}`).](#issue-2)

## Schema

The minimal gel schema demonstrating the error is in `dbschema/default.gel`.

<a id="issue-1"></a>
## Steps to Reproduce Issue [1]: Enum TypeError

1.  **Setup:**
    *   Clone repo: `git clone git@github.com:xerullian/drizzle-gel-enum.git && cd <repo-directory>`
    *   Install deps: `bun install`
    *   Ensure gel instance is running.
    *   Link project: `gel project init --link` (follow prompts)

2.  **Apply Schema:**

    ```bash
    gel migration create
    gel migrate
    ```

    *(Ensure the schema in `dbschema/default.gel` uses `module default {}`)*

3.  **Trigger Error:**

    ```bash
    bun drizzle-kit pull
    ```

## Expected Result

`drizzle-kit pull` completes successfully, generating `drizzle/schema.ts` (or configured output path) with `gelTable` definitions reflecting the schema in `dbschema/default.esdl`.

## Actual Result

The command fails with the `TypeError`

```
TypeError: Cannot read properties of null (reading 'toLowerCase')
    at column7 (/home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:83361:28)
    at /home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:83469:33
    at Array.forEach (<anonymous>)
    at createTableColumns2 (/home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:83467:15)
    at /home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:83207:22
    at Array.map (<anonymous>)
    at schemaToTypeScript2 (/home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:83201:61)
    at introspectGel (/home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:85833:18)
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5)
    at async Object.handler (/home/patricknolen/repos/test/drizzle-gel-test/node_modules/drizzle-kit/bin.cjs:92418:9)
```

<a id="issue-2"></a>
## Steps to Reproduce Issue 2: Non-Default Module

Issue [2] occurs when the schema in `dbschema/default.gel` uses `module foo {}` instead of `module default {}`.

## Steps to Reproduce

1.  **Cleanup for fresh start:**

    *   Delete the migration file in `dbschema/migrations/...`
    *   Run `gel branch main wipe`
    *   Confirm with 'Yes'

2.  **Setup:**

    *   Rename `module default {}` to `module foo {}`

3.  **Apply Schema:**

    ```bash
    gel migration create
    gel migrate
    ```

    *(Ensure the schema in `dbschema/default.gel` uses `module foo {}`)*

4.  **Run with no error:**

    ```bash
    bun drizzle-kit pull
    ```

## Expected Result

`drizzle-kit pull` completes successfully, generating `drizzle/schema.ts` reflecting the schema in `dbschema/default.gel`.

## Actual Result

The command completes successfully with output, but 0 definitions are fetched from the schema in `dbschema/default.gel`.

```
[✓] 0 tables fetched
[✓] 0 columns fetched
[⣷] 0 enums fetching
[✓] 0 indexes fetched
[✓] 0 foreign keys fetched
[⣷] 0 policies fetching
[⣷] 0 check constraints fetching
[⣷] 0 views fetching
```

## Environment (Example)

*   **Bun:** `1.2.2`
*   **`drizzle-kit`:** `0.30.6`
*   **`drizzle-orm`:** `0.41.0`
*   **`gel-cli`:** `7.2.0+70c7e2`
*   **Gel Server:** `6.4+4e5cda`
*   **OS:** `Nobara Linux 41 (KDE)`
