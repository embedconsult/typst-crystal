# Repository Purpose

This repository exists to perform a staged migration of `typst` from Rust to Crystal.

## Migration goals

- Easy inclusion within other Crystal projects.
- Faster execution through direct method invocation rather than `Process.run`.
- Easier-to-read source code and architecture in Crystal.
- A web server-side and client-side aligned implementation, similar to `typst.ts`.
