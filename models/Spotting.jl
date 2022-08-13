module Spotting

using Stipple
using StippleUI

using CSV, DataFrames
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

function readcsv(path="data", filename="df.csv")
  filepath = joinpath(path, filename)
  return DataFrame(CSV.File(filepath))
end

function readdata(path="data", filename="spotting.db")
  filepath = joinpath(path, filename)
  return SQLite.DB(filepath)
end

function writedata(data, path="data", filename="df.csv")
  filepath = joinpath(path, filename)
  CSV.write(filepath, data)
end

function writedata(data, db, tablename="df")
  SQLite.load!(data, db, tablename)
end

df = readcsv()

export Spotter

@reactive mutable struct Spotter <: ReactiveModel
  wells::R{DataTable} = DataTable(df, table_options)
end

function handlers(model::Spotter) :: Spotter
  return model
end

end
#=
julia> table_options
DataTableOptions(false, "ID", Column[Column("A", false, "A", :left, "A", true), Column("B", false, "B", :left, "B", true), Column("C", false, "C", :left, "C", true), Column("D", false, "D", :left, "D", true), Column("E", false, "E", :left, "E", true), Column("F", false, "F", :left, "F", true), Column("G", false, "G", :left, "G", true), Column("H", false, "H", :left, "H", true)], Dict{Union{Regex, String}, Dict{Symbol, Any}}())

julia> Stipple.render(DataTable(df, table_options), :wells)
Dict{String, Any} with 2 entries:
  "data_wells"    => Dict{String, Any}[Dict("B"=>"KY747", "A"=>"IO283", "__id"=>1, "C"=>"PS014", "D"=>"RY697", "G"=>"PJ195", "E"=>"CM526", "F"…
  "columns_wells" => Column[Column("A", false, "A", :left, "A", true), Column("B", false, "B", :left, "B", true), Column("C", false, "C", :lef…
=#
