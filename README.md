# F# Docker Images

F# is a cross-platform, functional programming language. It features a strong
type system, type inference, type providers and a lot of the niceties of OCaml.
These Docker images let you get started with F# quickly and build applications
based on F#.

The `mono` image contains the latest mono version with F#, whereas the `core`
image contains the latest .NET Core SDK and runtime.

You can choose between using a SDK image or a Runtime image. The Runtime image
is a minimal image with only the dependencies needed to **run** your 
already-compiled F# code, while the SDK image also has capabilities for 
**compiling** F#.

You can create runtime images by using a continuous integration services to
build the software; reference `FSharp.Core` from your app/service and copy the
final output into the Runtime container to create a container that contains
just your compiled app.

The up-side of doing it this way is a drastically reduced footprint of your
image which translates to lower storage-costs and quicker deploys. When that
bug hits the fan, you want to be able to quickly roll back your version or push
a fix – which means you benefit from lower image sizes.

# Dependency versions used:

## Mono Image
* Mono 4.8.0.495

## .NET Core Image
* .NET Core 1.1.1 Runtime
* .NET Core 1.0.1 SDK

# CMD

## Mono Image
The starting command for the `mono` image is `fsharpi` so running the image
will result in an F# interactive REPL.

### Usage

You can get an FSharp interactive session by simply running the fsharp image:
```
# docker run -it fsharp

F# Interactive for F# 4.1
Freely distributed under the Apache 2.0 Open Source License

For help type #help;;

> ["FSharp"; "in"; "Docker"] |> String.concat " " |> printfn "Hello from %s";;
Hello from FSharp in Docker
val it : unit = ()

```

You can also build and run some F# code in a container. This command will
write a short snippet to a Test.fs file, compile it, and then run it.
```
# docker run -it fsharp bash -c "echo 'let [<EntryPoint>] main argv = printfn \"Hello from FSharp in Docker\"; 0' > Test.fs && fsharpc Test.fs && mono Test.exe"

F# Compiler for F# 4.1
Freely distributed under the Apache 2.0 Open Source License
Hello from FSharp in Docker
```

With host volume mounts, you can attach a local source directory from 
your host machine, then do the build in a Docker image.  Below is an 
FSharp source file in the current directory.  Map that directory on 
the host to the `/src/` directory on the container with 

```
--volume `pwd`:/src
```

Then run the compiler and finally the application in the container.

After the applications exits, the resulting executable is left.

```
# ls 
Program.fs 

# docker run -it --rm --volume `pwd`:/src fsharp bash -c "cd /src; fsharpc Program.fs && mono Program.exe"

F# Compiler for F# 4.1
Freely distributed under the Apache 2.0 Open Source License

Perimeter of Circle 2.2 = 27.646015
Perimeter of Triangle (3.0,4.6,2.8) = 10.400000
Perimeter of Square 9.1 = 36.400000

# ls
Program.exe  Program.fs
```

To build an image of your own based on the `fsharp` image, create a Dockerfile 
such as the following:

```
FROM fsharp

ADD Program.fs src/
RUN cd src && fsharpc Program.fs
ENTRYPOINT ["mono", "/root/src/Program.exe"] 
```

This Dockerfile will copy the Program.fs file from the current directory into
the image.  Then it will change to that directory and compile it.  The final
step sets the entrypoint, so the resulting Docker image always runs the 
application.

Build this with `docker build -t myapp .`.

Then run with `docker run --rm myapp` and see that the application is run
directly.  The compilation step was performed when building the image, so this
image is ready to execute immediately:

```
# docker run --rm myapp
Perimeter of Circle 2.2 = 27.646015
Perimeter of Triangle (3.0,4.6,2.8) = 10.400000
Perimeter of Square 9.1 = 36.400000
```

## Core Image
The entry point for the `core` image in `/bin/bash` as there is no interactive
F# REPL available for .NET Core at this time.

Without a REPL, the primary use cases for the `core` image are building .NET
Core applications or using it as a base for another image.
