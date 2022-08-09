using Genie
using Stipple
using StippleUI
using StipplePlotly

using Stipple.Pages
using Stipple.ModelStorage.Sessions

using Proteus.Spotting

if Genie.Configuration.isprod()
  Genie.Assets.assets_config!([Genie, Stipple, StippleUI, StipplePlotly], host = "https://cdn.statically.io/gh/GenieFramework")
end

Page("/", view = "views/hello.jl.html",
          layout = "layouts/app.jl.html",
          model = () -> Spotter |> init_from_storage |> Spotting.handlers,
          context = @__MODULE__)
