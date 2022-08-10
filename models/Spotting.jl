module Spotting

using Stipple

using CSV, DataFrames
using Random: Xoshiro, randstring

const rng = Xoshiro(1234)

function genname()
  digits = UnitRange{UInt8}(48:57)
  uppercase_letters = UnitRange{UInt8}(65:90)
  return randstring(rng, uppercase_letters, 2) * randstring(rng, digits, 3)
end

function initdf()
  return repeat(
    DataFrame(A=genname(),B=genname(),C=genname(),D=genname(),E=genname(),F=genname(),G=genname(),H=genname()),
    outer=12)
end

function readdata(path="data/", filename="df.csv")
  filepath = path * filename
  return DataFrame(CSV.File(filepath))
end

function writedata(data, path="data/", filename="df.csv")
  filepath = path * filename
  CSV.write(filepath, data)
end

df = initdf()

export Spotter

@reactive mutable struct Spotter <: ReactiveModel
  message::R{String} = "Welcome to Proteus!"
  data::R{DataFrame} = df
end

function handlers(model::Spotter) :: Spotter
  #=
  on(model.message) do message
    model.isprocessing = true
    model.message[] = "Hello to you too!"
    model.isprocessing = false
  end
  =#

  model
end

end
