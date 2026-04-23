using HTTP
using Base.Threads

ingressos_disponiveis = 100

mutex = ReentrantLock()

function reservar()
    global ingressos_disponiveis

    lock(mutex)
    try
        if ingressos_disponiveis > 0
            ingressos_disponiveis -= 1
            println("SERVER Restantes: ", ingressos_disponiveis)
            return "Reserva Confirmada"
        else
            return "Ingressos Esgotados"
        end
    finally
        unlock(mutex)
    end
end

function handler(req)
    if req.target == "/reservar" && req.method == "GET"

        ch = Channel{String}(1)

        Threads.@spawn begin
            resultado = reservar()
            put!(ch, resultado)
        end

        resultado = take!(ch)

        return HTTP.Response(200, resultado)

    else
        return HTTP.Response(404, "Rota não encontrada")
    end
end

println("Servidor rodando em http://localhost:8080")

HTTP.serve(handler, "0.0.0.0", 8080)