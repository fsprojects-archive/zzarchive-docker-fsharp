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

# Installation

Once Docker is installed on your machine, type: `docker pull fsharp` as root. 

## Docker service on Linux

When `Cannot connect to the Docker daemon at {..} Is the docker daemon running?` appears:        
Run `systemctl start docker` in order to start it. In order to autostart the docker service, use `systemctl enable docker`.

# Dependency versions used:

## Mono Image
* Mono 6.4.0.198

## .NET Core Image
* .NET Core 3.0.100 SDK

# CMD

## Mono Image
The starting command for the `mono` image is `fsharpi` so running the image
will result in an F# interactive REPL running on the mono runtime.

After F# 10.2.3, the F# compiler switched to being built with the .NET Core SDK.
Because the mono fork of msbuild is behind, it doesn't support all of the features
of the .NET Core SDK that are necessary to build newer versions of the compiler.
As a result, the mono SDK image is still built with the older F# 10.2.3 compiler, 
supporting the F# 4.5 language.

## .NET Core Image
The starting command for the `netcore` image is `dotnet fsi` so running the image
will result in an F# interactive REPL running on the .NET Core runtime.  This
image includes the mono SDK as needed for some tooling, but is primarily used for
targeting .NET Core.

### Usage

You can get an FSharp interactive session by simply running the `fsharp` or `fsharp:netcore` image:
```
# docker run -it fsharp:netcore

Microsoft (R) F# Interactive version 10.6.0.0 for F# 4.7
Copyright (c) Microsoft Corporation. All Rights Reserved.

For help type #help;;

> ["FSharp"; "in"; "Docker"] |> String.concat " " |> printfn "Hello from %s";;
Hello from FSharp in Docker
val it : unit = ()

```

You can also build and run some F# code in a container. This command will
write a short snippet to a Test.fs file, compile it, and then run it.
```
# docker run -it fsharp bash -c "echo 'let [<EntryPoint>] main argv = printfn \"Hello from FSharp in Docker\"; 0' > Test.fs && fsharpc Test.fs && mono Test.exe"

Microsoft (R) F# Interactive version 10.2.3 for F# 4.5
Copyright (c) Microsoft Corporation. All Rights Reserved.
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

Microsoft (R) F# Interactive version 10.2.3 for F# 4.5
Copyright (c) Microsoft Corporation. All Rights Reserved.

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

WORKDIR /app

COPY Program.fs /app

RUN fsharpc Program.fs

ENTRYPOINT ["mono", "/app/Program.exe"] 
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
