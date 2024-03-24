import Pkg

Pkg.Registry.add(Pkg.RegistrySpec(url="https://github.com/cossio/CossioJuliaRegistry.git"))
Pkg.Registry.add("General")

Pkg.add([
    "FASTX",
    "LogExpFunctions",
    "MyRegistrator",
    "PythonCall",
    "PythonPlot",
    "Revise",
])
