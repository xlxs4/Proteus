module Spotting

using Stipple

export Spotter

@reactive mutable struct Spotter <: ReactiveModel
  message::R{String} = "Welcome to Proteus!"
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
