module AppModels

using Stipple

export AppModel

@reactive mutable struct AppModel <: ReactiveModel
  message::R{String} = "Welcome to Proteus!"
end

function handlers(model::AppModel) :: AppModel
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
