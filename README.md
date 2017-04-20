# F# Docker Image

F# is a cross-platform, functional programming language. It features a strong
type system, type inference, type providers and a lot of the niceties of OCaml.
This docker image lets you get started with F# quickly and build applications
based on F#.

The `mono` image contains the latest mono version with F#, whereas the `core`
image contains the latest .NET Core SDK and runtime.

# Dependency versions used:

## Mono Image
* Mono 4.8.0.495

## .NET Core Image
* .NET Core 1.1.1 Runtime
* .NET Core 1.0.1 SDK

# ENTRYPOINT

## Mono Image
The entry point for the `mono` image is `fsharpi` so that running the image
will result in an F# interactive REPL.

The entry point for the `core` image in `/bin/bash` as there is no interactive
F# REPL available for .NET Core at this time.