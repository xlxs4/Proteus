module Spotting

using Stipple
using StippleUI

using CSV, DataFrames, PrettyTables
using Random: Xoshiro, randstring
using SQLite

const table_options = DataTableOptions(columns = Column(["A", "B", "C", "D", "E", "F", "G", "H"]))

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

function readcsv(dirname::AbstractVector{String}, filename)
  return joinpath(dirname..., filename) |> CSV.File |> DataFrame
end

function readcsv(dirname::AbstractString, filename)
  return joinpath(dirname, filename) |> CSV.File |> DataFrame
end

function readdata(path="data", filename="spotting.db")
  filepath = joinpath(path, filename)
  return SQLite.DB(filepath)
end

function writecsv(data, dirname, filename)
  CSV.write(joinpath(dirname..., filename), data)
  return nothing
end

function writeio(data, dirname, filename)
  open(joinpath(dirname..., filename), "w") do io
    write(io, data)
  end
  return nothing
end

function tomarkdown(data)
  conf = set_pt_conf(tf = tf_markdown, alignment = :c)
  return pretty_table_with_conf(conf, String, data; header = names(data))
end

df = readcsv("data", "df.csv")

export Spotter

@reactive mutable struct Spotter <: ReactiveModel
  wells::R{DataTable} = DataTable(df, table_options)
end

function handlers(model::Spotter) :: Spotter
  return model
end

end
